//
//  CoreDataStack.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 03.07.2021.
//

import Foundation
import CoreData

final class CoreDataStack {
    private var modelName: String
	private let container: NSPersistentContainer
	var viewContext: NSManagedObjectContext { container.viewContext }
	lazy var backgroundContext: NSManagedObjectContext = container.newBackgroundContext()
	var coordinator: NSPersistentStoreCoordinator { container.persistentStoreCoordinator }

	init(modelName: String) {
        self.modelName = modelName
		let container = NSPersistentContainer(name: "SearchPhoto")
		self.container = container
	}

	func load() {
		container.loadPersistentStores { _, error in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
	}
    
    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getArrayData() -> [Recent] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        let results = try? viewContext.fetch(fetchRequest) as? [Recent]
        return results!
    }
    
	func deleteAll() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		_ = try? coordinator.execute(deleteRequest, with: viewContext)
	}

}
