//
// Created by hulkdx on 17/11/2018
//
import XCTest
@testable import MoneyManager
import RealmSwift

class DatabaseHelperTests: XCTestCase {
    
    var sut: DatabaseHelper!
    let realmHelper = MockRealmHelper()
    
    override func setUp() {
        sut = DatabaseHelper(realmHelper: realmHelper)
        realmHelper.config = Realm.Configuration(inMemoryIdentifier: "inMemoryRealm")
    }
    
    func test_insert_transactions_array_should_give_get_transactions() {
        // TODO
        let test_data = TestDataFactory.TRANSACTION_LIST_TEST
        sut.insert(test_data)
        
        let result_data = sut.getTransactions()
        //XCTAssertEqual(test_data, result_data)
    }
}

extension DatabaseHelperTests {
    class MockRealmHelper: RealmHelper {
        
    }
}
