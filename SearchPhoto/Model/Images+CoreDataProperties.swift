//
//  Images+CoreDataProperties.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/10/21.
//
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var width: Double
    @NSManaged public var height: Double

}
