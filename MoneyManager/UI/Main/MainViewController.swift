
//
//  Created by hulkdx on 27/01/2018.
//

import UIKit

class MainViewController: BaseViewController, MainMvpView {
    
    var presenter: MainPresenter<MainViewController>!

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.presenter = MainPresenter()
        
        onStart()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // How to also detachView it when it goes to background?
        // @see: https://stackoverflow.com/questions/18222052/view-controller-variables-in-applicationwillresignactive
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
