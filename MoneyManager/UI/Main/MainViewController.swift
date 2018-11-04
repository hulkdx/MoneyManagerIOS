
//
//  Created by hulkdx on 27/01/2018.
//

import UIKit

class MainViewController: BaseViewController, MainMvpView {
    
    var presenter: MainPresenter!

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.presenter = MainPresenter()
        presenter.attachView(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // How to also detachView it when it goes to background?
        // @see: https://stackoverflow.com/questions/18222052/view-controller-variables-in-applicationwillresignactive
        presenter.detachView()
    }

    //-----------------------
    // MvpViews methods
    //-----------------------
    
}
