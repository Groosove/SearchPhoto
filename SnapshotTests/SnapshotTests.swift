//
//  SnapshotTests.swift
//  SnapshotTests
//
//  Created by Артур Лутфуллин on 28.07.2021.
//

import XCTest
import SnapshotTesting
@testable import SearchPhoto

class SnapshotTests: XCTestCase {
	func testExample() {
		let vc = PhotosCollectionBuilder().build()
		
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX))
	}
}
