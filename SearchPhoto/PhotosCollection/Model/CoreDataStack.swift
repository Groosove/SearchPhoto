//
//  CoreDataStack.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 03.07.2021.
//

import Foundation
import CoreData

final class CoreDataStack {

	private let container: NSPersistentContainer
	var viewContext: NSManagedObjectContext { container.viewContext }
	lazy var backgroundContext: NSManagedObjectContext = container.newBackgroundContext()
	var coordinator: NSPersistentStoreCoordinator { container.persistentStoreCoordinator }

	init(modelName: String) {
		let container = NSPersistentContainer(name: modelName)
		self.container = container
	}

	func load() {
		container.loadPersistentStores { _, error in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
	}

	func deleteAll() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		_ = try? coordinator.execute(deleteRequest, with: viewContext)
	}

}
