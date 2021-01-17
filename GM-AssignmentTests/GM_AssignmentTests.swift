//
//  GM_AssignmentTests.swift
//  GM-AssignmentTests
//
//  Created by James Orlowski on 1/17/21.
//

import XCTest
@testable import GM_Assignment

class GM_AssignmentTests: XCTestCase {

    func testAPINetworkCall() throws {
        let expectation = self.expectation(description: "")
        expectation.expectedFulfillmentCount = 4
        
        // Standard use case. Make sure that the API is returning data + the status code is 200.
        APIUtility.fetchHistoryDataFromAPI(urlString: APIUtility.urlString) { (data: Data?, statusCode: Int?) in
            XCTAssertNotNil(data)
            XCTAssertTrue(statusCode == 200)
            expectation.fulfill()
        }
        
        // Test an invalid URL
        APIUtility.fetchHistoryDataFromAPI(urlString: "https://invalid url!!!") { (data: Data?, statusCode: Int?) in
            XCTAssertNil(data)
            XCTAssertNil(statusCode)
            expectation.fulfill()
        }
        
        APIUtility.fetchHistoryDataFromAPI(urlString: "https://httpstat.us/200") { (data: Data?, statusCode: Int?) in
            XCTAssertNotNil(data)
            XCTAssertTrue(statusCode == 200)
            expectation.fulfill()
        }
        
        APIUtility.fetchHistoryDataFromAPI(urlString: "https://httpstat.us/403") { (data: Data?, statusCode: Int?) in
            XCTAssertNotNil(data)
            XCTAssertTrue(statusCode == 403)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20)
    }
    
    func testJSONDecoding() {
        let dataTest1 = "Random string characters that isn't in JSON format!!".data(using: .utf8)!
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: dataTest1))
        
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: Data()))
    }
}
