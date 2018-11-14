//
// Created by hulkdx on 04/11/2018
//

class DataManager: DataManagerProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init() {
        networkService = NetworkService()
    }
    
    func getTransactionsRemote(completion: @escaping (DataResult<[Transaction]>) -> ()) {
        networkService.getTransactions(completion: completion)
    }
}

protocol DataManagerProtocol {
    func getTransactionsRemote(completion: @escaping (DataResult<[Transaction]>) -> ())
}
