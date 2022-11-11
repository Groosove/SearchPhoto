//
//  Recent.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/10/21.
//
//

import Foundation
import CoreData

@objc(Recent)
public final class Recent: NSManagedObject {

	/// Поисковый запрос
	@NSManaged public var search: String
}
