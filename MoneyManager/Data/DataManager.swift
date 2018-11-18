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

    // get data from the network and save it into the db
    func syncTransactions() {
        // print("syncTransactions, request network")
        networkService.getTransactions{ result in
            switch result {
            case .success(let transactionArray, let extra):
                let amountCount = extra as! Int
                //print("success, transactionArray: \(transactionArray), amountCount: \(amountCount)")
                self.databaseHelper.insert(transactionArray)
                break
            case .failed(let reason):
                print("failed")
                break
            }
        }
    }
    
    // get data from the various sources
    func getTransactions(completion: @escaping (DataResult<[Transaction]>) -> ()) {
        // TODO 1. Load it from cache first
        
        // 2. if failed load it from db
        
        // 3. if failed load it from network
        networkService.getTransactions(completion: completion)
    }
}

protocol DataManagerProtocol {
    func syncTransactions()
    func getTransactions(completion: @escaping (DataResult<[Transaction]>) -> ())
}
