//
//  DataManagerTests.swift
//  MoneyManagerTests
//
//  Created by saba rezvan on 05/11/2018.
//  Copyright © 2018 hulkdx. All rights reserved.
//

import XCTest
@testable import MoneyManager

class DataManagerTests: XCTestCase {
    
    var sut: DataManager!
    let networkService = MockNetworkService()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut                = DataManager()
        sut.networkService = networkService
    }

    func test_getTransactionsRemote_shouldcall_networkService() {
        sut.getTransactionsRemote{ ignore in}
        
        XCTAssert(networkService.isGetTransactionsCalled)
    }
}

extension DataManagerTests {
    class MockNetworkService: NetworkServiceProtocol {
        var isGetTransactionsCalled = false
        func getTransactions(completion: @escaping (DataResult<[Transaction]>) -> ()) {
            isGetTransactionsCalled = true
        }
    }
}
