//
//  ActivitiesTests.swift
//  EventsTests
//
//  Created by Thibault Lepez on 06/04/2021.
//

import XCTest

@testable import Events

class ActivitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingActivitesFromJSON() throws {
        let root: Root = Events.load("activities.json")
        let activities = root.activities
        
        XCTAssertNotNil(activities)
    }
    
    func testLoadingActivitiesFromAPI() throws {
        var activities: [Activity]?
        let expectation = self.expectation(description: "API call")

        Events.ApiService.call(Root.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule") { (data) in
            activities = data?.activities ?? nil
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(activities)
    }

    func testPerformanceOfLoadingActivitiesFromAPI() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            var _: [Activity]
            
            Events.ApiService.call(Root.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule") { (data) in
                _ = data?.activities ?? []
            }
        }
    }

}
