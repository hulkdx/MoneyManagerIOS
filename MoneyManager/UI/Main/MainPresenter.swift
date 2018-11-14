//
// Created by hulkdx on 04/11/2018
//
// Note: Couldn't figure out a way of doing Generic Type without using 
//       <T: BaseMvpView>, is there anyway of doing that? 

class MainPresenter<T: MainMvpView>: BasePresenter<T>, MainPresenterProtocol {
    
    var dataManager: DataManager!
    
    override init() {
        dataManager = DataManager()
    }
    
    func syncTransactions() {
        dataManager.getTransactionsRemote{ result in
            switch result {
            case .success(let transactionArray, let extra):
                let amountCount = extra as! Int
                print("success, transactionArray: \(transactionArray), amountCount: \(amountCount)")
                self.getView()?.showTransaction(transactions: transactionArray)
                break
            case .failed(_):
                print("failed")
                break
            }
        }
    }
}

protocol MainPresenterProtocol {
    func syncTransactions()
}
