//
// Created by hulkdx on 04/11/2018
//

import Foundation

protocol MainMvpView: BaseMvpView {
    func showTransaction(transactions: [Transaction])
}
