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
    let databaseHelper = MockDatabaseHelper()

    override func setUp() {
        sut                = DataManager(networkService: networkService, databaseHelper: databaseHelper)
    }

    func test_getTransactionsRemote_shouldcall_networkService() {
        sut.getTransactions{ ignore in}
        
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
    
    class MockDatabaseHelper: DatabaseHelperProtocol {
        
        func insert(_ transactionArray: [Transaction]) {
            
        }
        
    }
}
