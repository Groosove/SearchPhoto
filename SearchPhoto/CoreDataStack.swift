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

    func getAllRecents() -> [Recent] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
        let results = try? viewContext.fetch(fetchRequest) as? [Recent]
        return results!
    }
    
    func getAllImages() -> [Images] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        let results = try? viewContext.fetch(fetchRequest) as? [Images]
        return results!
    }
    
    func getImage(imageURL: String) -> Bool {
        let images = getAllImages()
        for item in images where item.imageURL == imageURL {
            return true
        }
        return false
    }
    
    func unlikeImages(imageURL: String) {
        let images = getAllImages()
        viewContext.performAndWait {
            for item in images {
                if item.imageURL == imageURL {
                    viewContext.delete(item)
                }
            }
        }
        try? viewContext.save()
    }
    
	func deleteAllRecents() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recent")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		_ = try? coordinator.execute(deleteRequest, with: viewContext)
	}

}
