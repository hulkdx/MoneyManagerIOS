//
// Created by hulkdx on 04/11/2018
//
// Note: Couldn't figure out a way of doing Generic Type without using 
//       <T: BaseMvpView>, is there anyway of doing that? 

import RxSwift

class MainPresenter<T: MainMvpView>: BasePresenter<T>, MainPresenterProtocol {
    
    var dataManager: DataManagerProtocol!
    var disposables: CompositeDisposable = CompositeDisposable()
    
    // For test (MainControllerTests.swift)
    override init() {}
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    override func detachView() {
        super.detachView()
        disposables.dispose()
    }
    
    func syncTransactions() {
        // Logger.log("syncTransactions")
        let disposable = dataManager.syncTransactions()
            .subscribe(onNext: { transaction in
                // Do nothing
            }, onError: commonErrors)
        let _ = disposables.insert(disposable)
    }
    
    func getTransactions() {
        // Logger.log("getTransactions")
        let disposable = dataManager.getTransactions()
            .subscribe(onNext: { transactions in
                        //Logger.log(transaction)
                self.getView()?.showTransaction(transactions: transactions)
            }, onError: commonErrors)
        let _ = disposables.insert(disposable)
    }
    
    func commonErrors(error: Error) {
        Logger.log("error: \(error)", functionName: Logger.getPreviousFunctionName())
    }
}

protocol MainPresenterProtocol: IPresenter {
    func syncTransactions()
    func getTransactions()
}
