//
//  Recent+CoreDataProperties.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/10/21.
//
//

import Foundation
import CoreData

extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent")
    }

    @NSManaged public var search: String

}
