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
	private let recentData = StackContainer.shared.coreDataStack

	func testSnapshotOnDifferentDevices() {
		let vc = CustomNavigationController(rootViewController: PhotosCollectionBuilder().build())
		recentData.deleteAllRecents()

		assertSnapshot(matching: vc, as: .image(on: .iPhone8Plus(.portrait)))
		assertSnapshot(matching: vc, as: .image(on: .iPhoneSe(.portrait)))
	}
}
