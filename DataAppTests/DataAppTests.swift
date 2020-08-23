//
//  DataAppTests.swift
//  DataAppTests
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import XCTest
@testable import DataApp
@testable import Alamofire

// test data fetch method
var sut: DataRequest!

class DataAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    // MARK: Data Fetch Test
    func testValidateCallToTheDataFetchAPI() {
        // Create URL String
        let urlStr = DAURL.main.rawValue + "/challenge" + ".json"
        
        // 1
        let promise = expectation(description: "Data Fetch Completed")
        
        var responseData: Data?
        var responseError: AFError?
        
        // when
        // 1 Request
        sut = AF.request(urlStr)
        
        // 2
        sut.responseJSON(completionHandler: { (data) in
            if data.data != nil {
                responseData = data.data!
            }
            else if data.error != nil {
                responseError = data.error!
            }
            promise.fulfill()
        })
        
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
    }

}
