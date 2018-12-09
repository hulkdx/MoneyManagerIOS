
//
//  Created by hulkdx on 27/01/2018.
//

import UIKit

class MainViewController: BaseViewController, MainMvpView {
    
    var presenter: MainPresenter<MainViewController>!

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.presenter = Injection.provideMainPresenter()
        
        onStart()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onStop()
    }
    
    deinit {
        onStop()
    }
        
    func onStart() {
        presenter.attachView(view: self)
        presenter.syncTransactions()
    }
    
    func onStop() {
        presenter.detachView()
    }

    //-----------------------
    // MvpViews methods
    //-----------------------
    
    func showTransaction(transactions: [Transaction]) {
        
    }
}
