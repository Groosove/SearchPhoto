//
//  SearchPhotoRandomImagesTest.swift
//  SearchPhotoTests
//
//  Created by Fenix Lavon on 7/25/21.
//

import XCTest
@testable import SearchPhoto

final class SearchPhotoRandomImagesTest: XCTestCase {

	private let service = HTTPHandler()

	override func setUp() {
		super.setUp()
		guard let _ = URL(string: Unsplash.baseURL + Unsplash.Methods.getImages) else { fatalError("Bad URL") }
	}

	override func tearDown() {
		super.tearDown()
	}

	func testGetRequestGoodData() throws {
		let parametrs = ["count": "30", "client_id": Unsplash.API.clientId]
		service.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getImages, parametrs: parametrs) { data in
			switch data {
			case .failure:
				XCTAssertTrue(true)

			default:
				XCTAssertTrue(false)
			}
		}
	}

	func testGetRequestWithoutParametrs() throws {
		service.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getImages, parametrs: [:]) { data in
			switch data {
			case .failure:
				XCTAssertTrue(false)

			default:
				XCTAssertTrue(true)
			}
		}
	}
}
