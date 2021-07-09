//
//  DIContainer.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/10/21.
//

import Foundation

final class Container {
    static let shared = Container()
    private var modelName: String = ""
    private init() {}
    func setModel(with name: String) -> Container {
        self.modelName = name
        return self
    }
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
}
