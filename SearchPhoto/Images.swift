//
//  Images.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/20/21.
//
//

import Foundation
import CoreData

@objc(Images)
public final class Images: NSManagedObject {

	/// Ссылка на изображение
	@NSManaged public var imageURL: String

	/// Идентификатор изображения
	@NSManaged public var uid: String

	/// Имя
	@NSManaged public var name: String

	/// Ширина
	@NSManaged public var width: Double

	/// Высота
	@NSManaged public var height: Double
}
