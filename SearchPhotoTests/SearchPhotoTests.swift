//
//  SearchPhotoTests.swift
//  SearchPhotoTests
//
//  Created by Артур Лутфуллин on 02.07.2021.
//

import XCTest
@testable import SearchPhoto

final class SearchPhotoSearchImagesTest: XCTestCase {

	private let service = HTTPHandler()

	override func setUp() {
		super.setUp()
		guard let _ = URL(string: Unsplash.baseURL + Unsplash.Methods.getImages) else { fatalError("Bad URL") }
	}

	override func tearDown() {
		super.tearDown()
	}

	func testGetRequestGoodData() throws {
		let parametrs = ["query": "Mom", "page": "1", "per_page": "50", "client_id": Unsplash.API.clientId]
		service.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getRandomImage, parametrs: parametrs) { data in
			switch data {
			case .failure:
				XCTAssertTrue(true)

			default:
				XCTAssertTrue(false)
			}
		}
	}

	func testGetRequestError() throws {
		let parametrs = [
			"query": "lgjalgjklahgklahklgahplghalghlakkhlgahklkhga",
			"page": "1",
			"per_page": "50",
			"client_id": Unsplash.API.clientId
		]
		service.get(baseURL: Unsplash.baseURL, endPoint: Unsplash.Methods.getImages, parametrs: parametrs) { data in
			switch data {
			case .failure:
				XCTAssertTrue(false)

			default:
				XCTAssertTrue(true)
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
