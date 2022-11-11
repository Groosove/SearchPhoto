//
//  StorageFactory.swift
//  MusicRoom
//
//  Created by Артур Лутфуллин on 29.12.2021.
//

final class Storage<T> {

	/// Слабая ссылка на зависимость
	weak var weakInstance: AnyObject?

	/// Синглтон зависиимости
	var sharedInstance: T?

	/// Фабрика создания новой зависимости
	let factory: (Container) throws -> T

	/// Тип создания зависимости
	let objectScope: Container.ObjectScope

	/// Конструктор
	/// - Parameters:
	///   - objectScope: Создагтя зависимости
	///   - factory: Фабрика, которая умеет создавать новую зависмость
	init(objectScope: Container.ObjectScope, factory: @escaping (Container) throws -> T) {
		self.objectScope = objectScope
		self.factory = factory
	}
}
