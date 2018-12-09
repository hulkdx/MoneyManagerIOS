//
// Created by hulkdx on 04/11/2018
//
// Base Presenter that is used by all Presenters
//

class BasePresenter<T: BaseMvpView>: IPresenter {
    
    private var view: T?
    
    func attachView(view: T) {
        // Logger.log("attachView")
        self.view = view
    }
    
    func detachView() {
        // Logger.log("detachView")
        view = nil
    }
    
    func isViewAttached() -> Bool {
        return view != nil
    }
    
    func getView() -> T? {
        return view
    }
}

protocol IPresenter {
    associatedtype T: BaseMvpView
    func attachView(view: T)
    func detachView()
}
