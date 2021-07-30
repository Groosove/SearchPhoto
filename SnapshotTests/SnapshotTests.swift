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
	func testSnapshotOnDifferentDevices() {
		let vc = CustomNavigationController(rootViewController: PhotosCollectionBuilder().build())
		assertSnapshot(matching: vc, as: .image(on: .iPhone8Plus(.portrait)))
		assertSnapshot(matching: vc, as: .image(on: .iPhoneSe(.portrait)))
	}
}
