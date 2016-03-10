//
//  NKHTTPRequestTests.swift
//  HackerNews
//
//  Created by Alex Telek on 10/03/2016.
//  Copyright © 2016 alextelek. All rights reserved.
//

import XCTest
@testable import NetworkKit

class NKHTTPRequestTests: XCTestCase {
    
    var expectationItem: NKHNTestItem?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        expectationItem = NKHNTestItem(data: [
            "id": "11245652",
            "by": "jergason",
            "kids": [11245801, 11245962, 11245988, 11246458, 11245828, 11246239, 11247401, 11246103, 11246312, 11246283, 11246651, 11245938, 11248198, 11247700, 11246079, 11245996, 11246061, 11246324, 11247246, 11249042, 11247608, 11246402, 11247078, 11246188, 11250241, 11246207, 11250426, 11246788, 11247452, 11246175, 11245831, 11254446, 11246106, 11246009, 11246892, 11247181, 11245832, 11250609, 11253252, 11246384, 11246748, 11246046, 11247933, 11250239],
            "title": "CocoaPods downloads max out five GitHub server CPUs",
            "type": "story",
            "parent": 0,
            "time": 1457449896
            ])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGETRequest() {
        let expectation = expectationWithDescription("Test GET HTTP Request")
        
        if !NKReachability.isNetworkAvailable() {
            XCTAssertTrue(true)
        } else {
            NKHTTPRequest.GET(
                "https://hacker-news.firebaseio.com/v0/item/11245652.json",
                params: ["print": "pretty"],
                success: { data in
                    
                    XCTAssertNotNil(data)
                    
                    var item: NKHNTestItem?
                    item <-- data
                    
                    XCTAssertEqual(item, self.expectationItem)
                    
                    expectation.fulfill()
                },
                failure: { error in
                    XCTFail(error.message)
                    
                    expectation.fulfill()
            })
            
            waitForExpectationsWithTimeout(10.0) { (error) -> Void in
                print(error)
            }
        }
    }
    
    func testInternetAvailability() {
        if NKReachability.isNetworkAvailable() {
            
            XCTAssertTrue(NKReachability.isNetworkAvailable())
            
        } else {
            
            XCTAssertTrue(!NKReachability.isNetworkAvailable())
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            
            NKHTTPRequest.GET(
                "https://hacker-news.firebaseio.com/v0/item/11245652.json",
                params: ["print": "pretty"],
                success: { data in
                },
                failure: { error in
            })
            
        }
    }
    
}