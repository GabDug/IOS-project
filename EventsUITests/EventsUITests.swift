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
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["activiy0"]/*[[".buttons[\"Breakout session, Breakout session (Friday), 2:30 PM - 3:20 PM\"]",".buttons[\"activiy0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Breakout session (Friday)"].buttons["Activities"].tap()
        activitiesListScrollView.otherElements.containing(.button, identifier:"activiy0").element.swipeUp()
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["activiy4"]/*[[".buttons[\"Panel, Technology in the household, 10:30 AM - 11:20 AM\"]",".buttons[\"activiy4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Technology in the household"].buttons["Activities"].tap()
        
        
    }
    
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
