//
//  DataManagerTests.swift
//  MoneyManagerTests
//
//  Created by saba rezvan on 05/11/2018.
//  Copyright © 2018 hulkdx. All rights reserved.
//

import XCTest
import RxSwift
@testable import MoneyManager

class DataManagerTests: XCTestCase {
    
    var sut: DataManager!
    let networkService = MockNetworkService()
    let databaseHelper = MockDatabaseHelper()

    override func setUp() {
        sut = DataManager(networkService: networkService, databaseHelper: databaseHelper)
    }
    
    func test_sync_tranction_call_networkService() {
        _ = sut.syncTransactions()
        XCTAssert(networkService.isGetTransactionsCalled)
    }

    func test_sync_tranction_call_database() {
        _ = sut.syncTransactions().subscribe()
        XCTAssert(databaseHelper.isAddTransactionsCalled)
    }
    
}

extension DataManagerTests {

    class MockNetworkService: NetworkServiceProtocol {
        var isGetTransactionsCalled = false
        
        func getTransactions() -> Observable<[Transaction]> {
            isGetTransactionsCalled = true
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST)
        }
        
    }
     
    class MockDatabaseHelper: DatabaseHelperProtocol {
        
        var isAddTransactionsCalled = false

        func addTransaction(_ transaction: Transaction) -> Observable<Transaction> {
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST[0])
        }
        
        func addTransactions(_ transactionArray: [Transaction]) -> Observable<[Transaction]> {
            isAddTransactionsCalled = true
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST)
        }
        
        func getTransactions() -> Observable<[Transaction]> {
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST)
        }
     
     }
}
