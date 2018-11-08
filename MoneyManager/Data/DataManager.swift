//
// Created by hulkdx on 04/11/2018
//

import SwiftyJSON

class DataManager: DataManagerProtocol {
    
    var networkService: NetworkService
    
    init() {
        networkService = NetworkService()
    }
    
    func getTransactionsRemote(completion: @escaping (DataResult<String>) -> ()) {
        networkService.getTransactions(completion: completion)
    }
}

protocol DataManagerProtocol {
    func getTransactionsRemote(completion: @escaping (DataResult<String>) -> ())
}
