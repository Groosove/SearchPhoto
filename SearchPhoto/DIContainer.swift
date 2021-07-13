//
//  DIContainer.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 04.07.21.
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
    lazy var coreDataStack = CoreDataStack(modelName: "SearchPhoto")
}
