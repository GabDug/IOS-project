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

    
    // Test a simple navigation of the app
    func testNavigation() throws {

        let app = XCUIApplication()
        let activitiesListScrollView = app.scrollViews["Activities List"]
        let elementsQuery = activitiesListScrollView.otherElements
        elementsQuery.buttons["activity0"].tap()
        app.navigationBars["Breakout session (Friday)"].buttons["Activities"].tap()
        activitiesListScrollView.otherElements.containing(.button, identifier:"activiy0").element.swipeUp()
        elementsQuery.buttons["activity4"].tap()
        app.navigationBars["Technology in the household"].buttons["Activities"].tap()
        
        
    }
    
    // Test existence of list elements
    func testElementsExistence_Activities() throws {
        
        
        
    
        
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
