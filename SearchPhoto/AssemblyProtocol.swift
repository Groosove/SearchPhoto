//
//  AssemblyProtocol.swift
//  MusicRoom
//
//  Created by Артур Лутфуллин on 30.12.2021.
//

/// Протокол для настройки зависимостей в слоях модуля
protocol AssemblyProtocol {

	/// Регистрация всех зависимостей слоя
	///
	/// - Parameter container: DI контейнер
	/// - Throws: при регистрации зависимости возникает исключение,
	/// Assembly прокидывает его вверх по иерархии вызовов
	func configure(_ container: ContainerProtocol)
}
