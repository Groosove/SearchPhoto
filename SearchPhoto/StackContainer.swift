//
//  StackContainer.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 04.07.21.
//
import Foundation

final class StackContainer {
	static let shared = StackContainer()
	private var modelName: String = ""
	private init() {}
	lazy var coreDataStack = CoreDataStack(modelName: "SearchPhoto")
}
