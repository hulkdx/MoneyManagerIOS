//
// Created by hulkdx on 04/11/2018
//

class DataManager: DataManagerDelegate {
    
    var networkService: NetworkService
    
    init() {
        networkService = NetworkService()
    }
    
    func getTransactionsRemote() {
        networkService.getTransactions()
    }
}

protocol DataManagerDelegate {
    func getTransactionsRemote()
}
