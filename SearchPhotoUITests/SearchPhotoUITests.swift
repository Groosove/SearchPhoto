//
//  SearchPhotoUITests.swift
//  SearchPhotoUITests
//
//  Created by Артур Лутфуллин on 02.07.2021.
//

import XCTest

class SearchPhotoUITests: XCTestCase {

    var app: XCUIApplication!

    override  func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSearchBarInPhotosCollection() throws {
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()

        let searchBar = app.navigationBars["Search Images"]
        searchBar.searchFields["Search"].tap()
        searchBar.typeText("Mom")

        XCUIApplication().keyboards.buttons["search"].tap()
        searchBar.buttons["Cancel"].tap()
        app.tables.children(matching: .button)["Clear"].tap()
    }
}
