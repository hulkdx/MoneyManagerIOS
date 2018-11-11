//
//  NetworkServiceTests.swift
//  MoneyManagerTests
//
//  Created by saba rezvan on 06/11/2018.
//  Copyright © 2018 hulkdx. All rights reserved.
//

import XCTest
@testable import MoneyManager

class NetworkServiceTests: XCTestCase {
    
    let NET_TIMEOUT = 3 as Double

    var sut: NetworkService!
    
    override func setUp() {
        sut = NetworkService()
    }
    
    func test_getTransactions_is_succesful_with_test_data() {
        // TODO add a test data and result the expected
        let e = expectation(description: "Network")
        
        sut.getTransactions{ result in
            var isFailed = false
            switch result {
            case .success(_):
                break
            case .failed(_):
                isFailed = true
                break
            }
            XCTAssert(!isFailed)
            e.fulfill()
        }
        
        waitForExpectations(timeout: NET_TIMEOUT, handler: nil)
    }

}
