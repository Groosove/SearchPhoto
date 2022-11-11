//
//  Container.swift
//  MusicRoom
//
//  Created by Артур Лутфуллин on 29.12.2021.
//

import Foundation

/// Протокол контейнера зависимостей
protocol ContainerProtocol {

	/// Регистрирует зависимость
	/// - Parameters:
	///   - type: Тип зависимости
	///   - factory: Фабрика порождающая зависимость
	func register<T>(type: T.Type, factory: @escaping (ContainerProtocol) throws -> T)

	/// Регистрирует зависимость
	/// - Parameters:
	///   - type: Тип зависимости
	///   - objectScope: Сущность, описывающий время жизни зарегистрированной зависимости
	///   - name: Имя регистрируемой зависимости
	///   - factory: Фабрика порождающая зависимость
	func register<T>(type: T.Type,
					 objectScope: Container.ObjectScope,
					 name: String?,
					 factory: @escaping (ContainerProtocol) throws -> T)

	/// Регистрирует зависимость
	/// - Parameters:
	///   - type: Тип зависимости
	///   - objectScope: Сущность, описывающий время жизни зарегистрированной зависимости
	///   - factory: Фабрика порождающая зависимость
	func register<T>(type: T.Type, objectScope: Container.ObjectScope, factory: @escaping (ContainerProtocol) throws -> T)

	/// Возвращает зависимость без явного указания типа
	func resolve<T>() throws -> T

	/// Возвращает зависимость
	/// - Parameter type: Тип зависимости
	func resolve<T>(type: T.Type) throws -> T

	/// Возвращает зависимость
	/// - Parameters:
	///   - type: Тип зависимости
	///   - name: Имя возвращаемой зависимости
	func resolve<T>(type: T.Type, name: String?) throws -> T
}

extension ContainerProtocol {

	func register<T>(type: T.Type, factory: @escaping (ContainerProtocol) throws -> T) {
		register(type: type, objectScope: .unique, name: nil, factory: factory)
	}

	func register<T>(type: T.Type, objectScope: Container.ObjectScope, factory: @escaping (ContainerProtocol) throws -> T) {
		register(type: type, objectScope: objectScope, name: nil, factory: factory)
	}

	func resolve<T>() throws -> T {
		try resolve(type: T.self, name: nil)
	}

	func resolve<T>(type: T.Type) throws -> T {
		try resolve(type: type, name: nil)
	}
}

/// Container класс, позволяющий управлять зависимостями.
/// Note:
///  - Резолв зависимостей не синхронизирован
///
/// Пример регистрации зависимости:
///
/// let container = Container()
/// container.register(type: House.self) { _ in
/// 	House()
/// }
/// container.register(type: City.self) { r in
/// 	City(house: r.resolve(House.self)
/// }
///
/// Пример резолва зависимости:
///
/// try? container.resolve(type: City.self)
///
final class Container: ContainerProtocol {

	// MARK: - Properties

	/// Зарегистрированные зависимости
	private(set) var storage: [Key: Any] = [:]

	// MARK: - ContainerProtocol

	func register<T>(type: T.Type,
					 objectScope: ObjectScope = .unique,
					 name: String?,
					 factory: @escaping (ContainerProtocol) throws -> T) {
		storage[Key(type: type, name: name)] = Storage(objectScope: objectScope, factory: factory)
	}

	func resolve<T>(type: T.Type, name: String?) throws -> T {
		guard let storage = storage[Key(type: type, name: name)] as? Storage<T> else {
			throw Container.Error.registration(message: "Не найдена регистрация для: \(type)!")
		}

		switch storage.objectScope {
		case .unique:
			return try storage.factory(self)

		case .shared:
			guard let instance = storage.sharedInstance else {
				let instance = try storage.factory(self)
				defer { storage.sharedInstance = instance }
				return instance
			}
			return instance

		case .weak:
			guard let instance = storage.weakInstance as? T else {
				let instance = try storage.factory(self)
				defer { storage.weakInstance = instance as AnyObject }
				return instance
			}
			return instance
		}
	}
}

extension Container {

	/// Ключ по которому хранится зависимость в контейнере
	struct Key: Hashable {

		/// Тип зависимости
		let type: Any.Type

		/// Название зависимости
		let name: String?

		// MARK: - Hashable

		func hash(into hasher: inout Hasher) {
			ObjectIdentifier(type).hash(into: &hasher)
			name?.hash(into: &hasher)
		}

		// MARK: Equatable

		static func == (lhs: Container.Key, rhs: Container.Key) -> Bool {
			return lhs.type == rhs.type &&
				   lhs.name == rhs.name
		}
	}

	/// Ошибка контейнера
	enum Error: LocalizedError {

		/// Не найдена регистрация
		case registration(message: String)

		/// Не удалось распознать тип
		case typeCasting
	}

	/// Определяет как создается экземпляр в контейнере.
	enum ObjectScope {

		/// Зависимость создается заново при каждом резолве.
		case unique

		/// Создается одна общая зависимость.
		case shared

		/// Зависимость будет существовать, пока на нее есть сильная ссылка. В ином случае зависимость создается заново.
		case weak
	}
}
