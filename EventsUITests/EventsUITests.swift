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
        app.scrollViews["Activities List"].otherElements.buttons["Keynote, Opening remarks (Friday), 10:00 AM - 10:25 AM"].tap()
        app.navigationBars["Opening remarks (Friday)"].buttons["Activities"].tap()
        
        
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
    
    // Test a complex navigation of the app
    func testNavigation_Complex() throws {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews["Activities List"].otherElements
        elementsQuery.buttons["Panel, How to make all your devices play nice, 10:30 AM - 11:20 AM"].tap()
        app.navigationBars["How to make all your devices play nice"].swipeUp()
        app.navigationBars["How to make all your devices play nice"].swipeDown()
        app.navigationBars["How to make all your devices play nice"].buttons["Activities"].tap()
        
        elementsQuery.buttons["Workshop, Workshop for security professionals, 11:30 AM - 12:00 PM"].tap()
        app.navigationBars["Workshop for security professionals"].buttons["Activities"].tap()
        
        elementsQuery.buttons["Panel, Which security solution is best for you?, 1:30 PM - 2:20 PM"].tap()
        let elementsQuery2 = app.scrollViews.otherElements.scrollViews.otherElements
        elementsQuery2.buttons["SO, Stephan Oswald"].tap()
        app.navigationBars["Stephan Oswald"].buttons["Which security solution is best for you?"].tap()
        app.navigationBars["Which security solution is best for you?"].buttons["Activities"].tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Sponsors"].tap()
        app.scrollViews["Sponsors Container"].otherElements.scrollViews.otherElements.buttons["NANA, National Association of Neighborhood Associations "].tap()
        elementsQuery2.buttons["CR, Clara Rotelli"].tap()
        app.navigationBars["Clara Rotelli"].buttons["National Association of Neighborhood Associations"].tap()
        app.navigationBars["National Association of Neighborhood Associations"].buttons["Sponsors"].tap()
        tabBar.buttons["Attendees"].tap()
        app.scrollViews["Attendees Container"].otherElements.buttons["SE, Sam Epps"].tap()
        app.navigationBars["Sam Epps"].buttons["Attendees"].tap()
        
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
