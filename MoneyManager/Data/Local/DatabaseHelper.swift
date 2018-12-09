//
// Created by hulkdx on 16/11/2018
//

import RealmSwift
import RxSwift

class DatabaseHelper: DatabaseHelperProtocol {
    
    let realmHelper: RealmHelper
    
    init(realmHelper: RealmHelper) {
        self.realmHelper = realmHelper
    }
    
    //-----------------------
    // Commons
    //-----------------------
    
    // TODO
    
    //-----------------------
    // Transactions
    //-----------------------
    
    func getTransactions() -> Observable<[Transaction]> {
        // Logger.log("getTransactions")
        return Observable.create { (observer) -> Disposable in
            
            var token: NotificationToken? = nil
            
            do {
                let realm  = try self.realmHelper.getRealm()
                let result = realm.objects(TransactionRealm.self)
                
                token = result.observe({ (changes) in
                    switch changes {
                    case .initial(_):
                        break
                    case .update(let changedResult, _, _, _):
                        let data = DatabaseModelMapper.convert(changedResult)
                        observer.onNext(data)
                        break
                    case .error(let error):
                        observer.onError(error)
                    }
                })
                
                let data   = DatabaseModelMapper.convert(result)
                observer.onNext(data)

            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create {
                token?.invalidate()
            }
            
        }
    }
    
    func addTransaction(_ transaction: Transaction) -> Observable<Transaction> {
        //Logger.log("addTransaction")
        
        return Observable.create { (observer) -> Disposable in
            
            var pRealm: Realm? = nil
            do {
                let realm  = try self.realmHelper.getRealm()
                pRealm = realm
                realm.beginWrite()
                //Logger.log("insert transaction: \(transaction)")
                let transactionRealm = DatabaseModelMapper.convert(transaction)
                realm.add(transactionRealm, update: true)
                try realm.commitWrite()

                observer.onNext(transaction)
                
            } catch let error {
                Logger.log("error: \(error)")
                observer.onError(error)
            }
            
            return Disposables.create {
                if let realm = pRealm {
                    realm.cancelWrite()
                }
            }
        }
    }
    
    
    func addTransactions(_ transactionArray: [Transaction]) -> Observable<[Transaction]> {
        //Logger.log("addTransactions")
        
        return Observable.create { (observer) -> Disposable in
            
            var pRealm: Realm? = nil
            do {
                let realm  = try self.realmHelper.getRealm()
                pRealm = realm
                realm.beginWrite()
                
                for transaction in transactionArray {
                    // Logger.log("insert transaction: \(transaction)")
                    let transactionRealm = DatabaseModelMapper.convert(transaction)
                    realm.add(transactionRealm, update: true)
                }
                
                try realm.commitWrite()
                observer.onNext(transactionArray)
                
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create {
                if let realm = pRealm {
                    realm.cancelWrite()
                }
            }
        }
    }
    
    //-----------------------
    // TODO: Category
    //-----------------------
}

protocol DatabaseHelperProtocol {
    func addTransaction(_ transaction: Transaction)         -> Observable<Transaction>
    func addTransactions(_ transactionArray: [Transaction]) -> Observable<[Transaction]>
    func getTransactions()                                  -> Observable<[Transaction]>
}

