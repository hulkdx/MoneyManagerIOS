//
// Created by hulkdx on 04/11/2018
//

import XCTest
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
        
        XCTAssert(dataManager.is_get_transactions_remote_called)
    }

}

//
// The mocks
//

extension MainPresenterTests {
    class MockView: MainMvpView {
        
    }
    
    class MockDataManager: DataManager {
        var is_get_transactions_remote_called = false
        
        override func getTransactionsRemote(completion: @escaping (DataResult<String>) -> ()) {
            super.getTransactionsRemote(completion: completion)
            is_get_transactions_remote_called = true
        }
    }
}
