//
//  EventsUITests.swift
//  EventsUITests
//
//  Created by Gabriel on 30/03/2021.
//

import XCTest

class EventsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTitle() throws {
        let title = app.staticTexts["SW Caracters"]
        XCTAssert(title.exists)
        XCTAssertEqual(title.label, "SW Caracters")
    }
    
    func testNumberOfRow() throws {
        let tableView = app.tables["tableView"]
        XCTAssert(tableView.exists)
        XCTAssertTrue(tableView.cells.count > 0)
    }

    func testRowDisplay() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.firstMatch
        
        XCTAssertTrue(cell.images.count == 1)
        XCTAssertTrue(cell.staticTexts.count == 1)
    }
    
    func testNavigation() throws {
        let tableView = app.tables.firstMatch
        let cell = tableView.cells.firstMatch
        
        cell.tap()
        let title = app.staticTexts["SW Caracters"]
        XCTAssertFalse(title.exists)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
