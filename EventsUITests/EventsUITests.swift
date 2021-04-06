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
    func testNavigation_Activities() throws {
        
        let app = XCUIApplication()
        let activitiesListScrollView = app.scrollViews["Activities List"]
        let activiesContainerElement = activitiesListScrollView.otherElements.containing(.button, identifier:"Activies Container").element
        activiesContainerElement.swipeUp()
        activiesContainerElement.swipeUp()
        activiesContainerElement.swipeUp()
        
        let panelHowToMakeAllYourDevicesPlayNice1030Am1120AmButton = activitiesListScrollView.otherElements.buttons["Panel, How to make all your devices play nice, 10:30 AM - 11:20 AM"]
        panelHowToMakeAllYourDevicesPlayNice1030Am1120AmButton.tap()
        app.navigationBars["How to make all your devices play nice"].buttons["Activities"].tap()
        
        
    }
    
    // Test a simple navigation of the app
    func testNavigation_Sponsors() throws {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Sponsors"].tap()
        
        let sponsorsContainerScrollView = app.scrollViews["Sponsors Container"]
        sponsorsContainerScrollView.otherElements.containing(.staticText, identifier:"Pledged $").element.swipeUp()
        sponsorsContainerScrollView.otherElements.scrollViews.otherElements.buttons["AE, Absolute Electric"].tap()
        app.navigationBars["Absolute Electric"].buttons["Sponsors"].tap()
        
    }
    
    // Test a simple navigation of the app
    func testNavigation_Attendees() throws {

        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Attendees"].tap()
        
        let elementsQuery = app.scrollViews["Attendees Container"]
        elementsQuery.swipeUp()
        elementsQuery.buttons["PD, Peyton Devereaux"].tap()
        app.navigationBars["Peyton Devereaux"].buttons["Attendees"].tap()
        
        
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
