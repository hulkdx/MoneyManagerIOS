//
//  MoneyManagerTests.swift
//  MoneyManagerTests
//
//  Created by saba rezvan on 04/11/2018.
//  Copyright © 2018 hulkdx. All rights reserved.
//

import XCTest
@testable import MoneyManager

class MainViewControllerTests: XCTestCase {
    
    var sut: MainViewController!
    
    let presenter = MockMainPresenter()

    override func setUp() {
        sut = MainViewController()
        // access loadView, viewDidLoad
        // _   = sut.view
        sut.presenter = presenter
    }

    func test_should_attachview_on_viewdidload() {
        sut.onStart()
        XCTAssert(presenter.isViewAttached())
    }
    
    func test_should_sync_transaction_on_viewdid_oad() {
        sut.onStart()
        XCTAssert(presenter.isSyncTransactionsCalled)
    }
}

extension MainViewControllerTests {
    class MockMainPresenter: MainPresenter<MainViewController> {
        var isSyncTransactionsCalled = false
        
        override func syncTransactions() {
            isSyncTransactionsCalled = true
        }
    }
}
