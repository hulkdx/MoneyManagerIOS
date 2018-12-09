//
// Created by hulkdx on 04/11/2018
//

import XCTest
import RxSwift
@testable import MoneyManager

class MainPresenterTests: XCTestCase {
    
    var sut: MainPresenter<MockView>!
    var view = MockView()
    var dataManager = MockDataManager()
    
    override func setUp() {
        sut = MainPresenter()
        sut.dataManager = dataManager
        sut.attachView(view: view)
    }
    
    func test_sync_transaction_should_call_data_manager() {
        sut.syncTransactions()
        
        XCTAssert(dataManager.is_sync_transactions_called)
    }

    func test_sync_transaction_should_call_view_showTransaction() {
        // 
        
        sut.getTransactions()

        // verify?
        XCTAssert(view.is_showTransaction_called)
    }
}

//
// Mocks
//

extension MainPresenterTests {
    class MockView: MainMvpView {
        var is_showTransaction_called = false
        func showTransaction(transactions: [Transaction]) {
            is_showTransaction_called = true
        }
    }
    
    class MockDataManager: DataManagerProtocol {
        
        var is_get_transactions_called = false
        var is_sync_transactions_called = false
        var get_failed_data = false
        
        func syncTransactions() -> Observable<[Transaction]> {
            is_sync_transactions_called = true
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST)
        }
        
        func getTransactions() -> Observable<[Transaction]> {
            is_sync_transactions_called = true
            return Observable.just(TestDataFactory.TRANSACTION_LIST_TEST)
        }
        
    }
}
