//
//  SponsorsTests.swift
//  EventsTests
//
//  Created by Thibault Lepez on 06/04/2021.
//

import XCTest

@testable import Events

class SponsorsTests: XCTestCase {

    func testLoadingFromJSON() throws {
        let root: RootSponsors = ModelData.load("sponsor.json")
        let sponsors = root.sponsors
        
        XCTAssertNotNil(sponsors)
    }
    
    func testLoadingFromAPI() throws {
        var sponsors: [Sponsor]? = nil
        let expect = expectation(description: "API call")
        
        Events.ApiService.call(RootSponsors.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors") { (data) in
            sponsors = data?.sponsors
            expect.fulfill()
        } errorHandler: { _ in }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(sponsors)
    }

    func testPerformanceForAPILoad() throws {
        // This is an example of a performance test case.
        self.measure {
            Events.ApiService.call(RootSponsors.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors") {_ in } errorHandler: { _ in }
        }
    }

}
