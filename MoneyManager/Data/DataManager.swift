//
// Created by hulkdx on 04/11/2018
//

import RxSwift

class DataManager: DataManagerProtocol {
    
    let networkService: NetworkServiceProtocol
    let databaseHelper: DatabaseHelperProtocol
    
    init(networkService: NetworkServiceProtocol,
        databaseHelper: DatabaseHelperProtocol) {
        self.networkService = networkService
        self.databaseHelper = databaseHelper
    }
    
    //-----------------------
    // Transactions
    //-----------------------

    // get data from the network and save it into the db
    func syncTransactions() -> Observable<[Transaction]> {
        return networkService.getTransactions()
            .concatMap { (transactions) -> Observable<[Transaction]> in
                return self.databaseHelper.addTransactions(transactions)
            }
    }
    
    // get data from the various sources
    func getTransactions() -> Observable<[Transaction]> {
        return databaseHelper.getTransactions()
    }
}

protocol DataManagerProtocol {
    func syncTransactions() -> Observable<[Transaction]> 
    func getTransactions() -> Observable<[Transaction]> 
}
