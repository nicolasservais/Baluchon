//
//  ViewTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 15/10/2021.
//

import XCTest
@testable import Baluchon

class ViewTests: XCTestCase {

    func testInitWithCoderRefreshButton() {
        let refreshButton = RefreshButton(coder: NSCoder())
        XCTAssertNil(refreshButton)
    }
    func testInitWithCoderMeteoView() {
        let meteoView = MeteoView(coder: NSCoder())
        XCTAssertNil(meteoView)
    }
    func testInitWithCodertranslateView() {
        let translateView = TranslateView(coder: NSCoder())
        XCTAssertNil(translateView)
    }
    func testInitWithCoderChangeView() {
        let changeView = ChangeView(coder: NSCoder())
        XCTAssertNil(changeView)
    }

}
