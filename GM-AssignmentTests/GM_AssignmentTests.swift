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
        expectation.expectedFulfillmentCount = 1
        
        // Standard use case. Make sure that the API is returning data + the status code is 200.
        APIUtility.fetchHistoryDataFromAPI(urlString: APIUtility.urlString) { (data: Data?, statusCode: Int?) in
            XCTAssertNotNil(data)
            XCTAssertTrue(statusCode == 200)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20)
    }
}
