//
// Created by hulkdx on 04/11/2018
//
// Note: Couldn't figure out a way of doing Generic Type without using 
//       <T: BaseMvpView>, is there anyway of doing that? 

class MainPresenter<T: BaseMvpView>: BasePresenter<T>, MainPresenterDelegate {
    
    var dataManager: DataManager!
    
    override init() {
        dataManager = DataManager()
    }
    
    func syncTransactions() {
        dataManager.getTransactionsRemote{ result in
            // TODO 
        }
    }
}

protocol MainPresenterDelegate {
    func syncTransactions()
}
