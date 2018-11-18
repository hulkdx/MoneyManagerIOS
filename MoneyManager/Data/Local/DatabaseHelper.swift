//
// Created by hulkdx on 16/11/2018
//

import RealmSwift

class DatabaseHelper: DatabaseHelperProtocol {
    
    let realmHelper: RealmHelper
    
    init(realmHelper: RealmHelper) {
        self.realmHelper = realmHelper
    }
    
    //-----------------------
    // Transactions
    //-----------------------
    
    func getTransactions() -> [Transaction] {
        let realm = try! realmHelper.getRealm()
        let result = realm.objects(TransactionRealm.self)
        return DatabaseModelMapper.convert(result)
    }
    
    func insert(_ transaction: Transaction) {
        let realm = try! realmHelper.getRealm()
        
        try! realm.write {
            print("insert transaction: \(transaction)")
            let transactionRealm = DatabaseModelMapper.convert(transaction)
            realm.add(transactionRealm, update: true)
        }
    }
    
    
    func insert(_ transactionArray: [Transaction]) {
        let realm = try! realmHelper.getRealm()
        
        try! realm.write {
            for transaction in transactionArray {
                print("insert transaction: \(transaction)")
                let transactionRealm = DatabaseModelMapper.convert(transaction)
                realm.add(transactionRealm, update: true)
            }
        }
    }
    
    //-----------------------
    // TODO: Category
    //-----------------------
}

protocol DatabaseHelperProtocol {
    func insert(_ transaction: Transaction)
    func insert(_ transactionArray: [Transaction])
    func getTransactions() -> [Transaction]
}

