//
//  UtilsTests.swift
//  EventsTests
//
//  Created by Thibault Lepez on 06/04/2021.
//

import XCTest
import MapKit

@testable import Events

class UtilsTests: XCTestCase {

    func testDiffColorsFormDiffIds() throws {
        let color1 = Events.ColorUtils.newColorFromId(userId: "azerty")
        let color2 = Events.ColorUtils.newColorFromId(userId: "qwerty")
        
        XCTAssertNotEqual(color1, color2)
    }
    
    func testInitialsFromSimpleName() throws {
        let initals = Events.NameUtils.initialsFromName(name: "Thibault LEPEZ")
        
        XCTAssertEqual(initals, "TL")
    }
    
    func testInitialsFromComplexName() throws {
        let initals = Events.NameUtils.initialsFromName(name: "Thibault of the Hill")
        
        XCTAssertEqual(initals, "TH")
    }
    
    func testLocationFromAddress() throws {
        let expect = expectation(description: "Address converiton")
        var coord: CLLocationCoordinate2D? = nil
        
        Events.LocationUtils.coordinates(forAddress: "64 rue Saint-Roch, Villejuif, France") { coordinate in
            coord = coordinate
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(coord)
    }
}
