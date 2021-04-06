//
//  ServicesTests.swift
//  EventsTests
//
//  Created by Thibault Lepez on 06/04/2021.
//

import XCTest

@testable import Events

class ServicesTests: XCTestCase {

    func testJSONLoadingError() throws {
        XCTAssertThrowsError(Events.load("test.json") as [Sponsor])
    }

    func testAPILoadingError() throws {
        Events.ApiService.call(Speaker.self, url: "error.com", completionHandler: {
            _ in
        }, errorHandler: { _ in })
    }

}
