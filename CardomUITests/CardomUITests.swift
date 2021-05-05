//
//  CardomUITests.swift
//  CardomUITests
//
//  Created by Thibault Le Cornec on 05/05/2021.
//

import XCTest

class CardomUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactCellToContactDetails() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // UI tests must launch the application that they test.
        sleep(5)
        let cell = app.tables.cells.matching(identifier: "contact_list_cell").firstMatch
        guard cell.exists else {
            XCTFail("No cell with ID `contact_list_cell`!")
            return
        }
        cell.tap()
        sleep(2)
        //        print(app.debugDescription)
        XCTAssertTrue(app.tables["contact_details_view_controller"].exists, "No view with ID `contact_details_view_controller`!")
    }
}
