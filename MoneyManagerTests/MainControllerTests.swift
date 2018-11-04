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
    var presenter = MainPresenter()

    override func setUp() {
        sut = MainViewController()
        // access loadView, viewDidLoad
        // _   = sut.view
        sut.presenter = presenter
    }

    func test_should_sync_data_on_view_did_load() {
        sut.onStart()
        XCTAssert(presenter.isViewAttached())
    }
}

extension MainViewControllerTests {
    class MockMainPresenter: MainPresenter {
        
    }
}
