//
//  ServicesTests.swift
//  EventsTests
//
//  Created by Thibault Lepez on 06/04/2021.
//

import XCTest

@testable import Events

class ServicesTests: XCTestCase {

    func testJSONWithWrongPath() throws {
        expectFatalError(expectedMessage: "Couldn't find test.json in main bundle.") {
            var _: Root = ModelData.load("test.json")
        }
    }
    
    func testJSONWithWrongData() throws {
        expectFatalError(expectedMessage: "Couldn't parse activities.json") {
            var _: RootSponsors = ModelData.load("activities.json")
        }
    }

    func testAPIWithWrongURL() throws {
        Events.ApiService.call(Speaker.self, url: "error.com", completionHandler: {
            _ in
        }, errorHandler: { _ in })
    }
    
    
    func testAPIWithWrongEndpoint() throws {
        Events.ApiService.call(Speaker.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/wrongId", completionHandler: {
            _ in
        }, errorHandler: { _ in })
    }
    
    func testAPIWithWrongData() throws {
        Events.ApiService.call(Activity.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees", completionHandler: {
            _ in
        }, errorHandler: { _ in })
    }

}
