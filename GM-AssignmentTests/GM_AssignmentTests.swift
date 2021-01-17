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
        
        // Test model properties are being set
        let dataTest2 = #"[ { "sha": "a hash value", "commit": { "author": { "name": "a name value" } , "message": "a commit message"} } ]"#.data(using: .utf8)!
        let jsonData2 = APIUtility.decodeJSONData(jsonData: dataTest2)
        XCTAssertNotNil(jsonData2)
        XCTAssert(jsonData2!.count == 1)
        XCTAssert(jsonData2![0].sha == "a hash value")
        XCTAssert(jsonData2![0].commit.author.name == "a name value")
        XCTAssert(jsonData2![0].commit.message == "a commit message")
        
        // Test with multiple commit entries
        let dataTest3 = #"[ { "sha": "", "commit": { "author": { "name": "" } , "message": ""} }, { "sha": "", "commit": { "author": { "name": "" } , "message": ""} } ]"#.data(using: .utf8)!
        let jsonData3 = APIUtility.decodeJSONData(jsonData: dataTest3)
        XCTAssertNotNil(jsonData3)
        XCTAssert(jsonData3!.count == 2)
        
        // Rename "sha" -> "sha1". Decoding should then fail
        let dataTest4 = #"[ { "sha1": "a hash value", "commit": { "author": { "name": "a name value" } , "message": "a commit message"} } ]"#.data(using: .utf8)!
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: dataTest4))
        
        // Change message value to an int.
        let dataTest5 = #"[ { "sha": "a hash value", "commit": { "author": { "name": "a name value" } , "message": 1} } ]"#.data(using: .utf8)!
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: dataTest5))
        
        // Remove the sha entry completely
        let dataTest6 = #"[ { "commit": { "author": { "name": "a name value" } , "message": 1} } ]"#.data(using: .utf8)!
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: dataTest6))
        
        // Change author value to null
        let dataTest7 = #"[ { "commit": { "author": { "name": null } , "message": 1} } ]"#.data(using: .utf8)!
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: dataTest7))
        
        XCTAssertNil(APIUtility.decodeJSONData(jsonData: Data()))
    }
}
