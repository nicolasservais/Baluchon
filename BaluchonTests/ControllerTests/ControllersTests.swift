//
//  ControllersTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 15/10/2021.
//

import XCTest
@testable import Baluchon

class ControllersTests: XCTestCase {

    func testInitWithCoderTabViewController() {
        let tabView = TabViewController(coder: NSCoder())
        XCTAssertNil(tabView)
    }
    func testInitWithCoderMeteoViewController() {
        let meteoView = MeteoViewController(coder: NSCoder())
        XCTAssertNil(meteoView)
    }
    func testInitWithCoderTranslateViewController() {
        let translateView = TranslateViewController(coder: NSCoder())
        XCTAssertNil(translateView)
    }
    func testInitWithCoderChangeViewController() {
        let changeView = ChangeViewController(coder: NSCoder())
        XCTAssertNil(changeView)
    }
    func testPlaceEmptyInMeteoViewController() {
        let meteoController = MeteoViewController(space: Space())
        let refreshButton: RefreshButton = RefreshButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), style: .valid, name: "")
        meteoController.setPlaceLocal(value: "lyon")
        meteoController.setPlaceOther(value: "ttt")
        meteoController.tappedRefreshButton(_sender: refreshButton)
        sleep(3)
//        meteoController.setPlaceLocal(value: "ttt")
//        meteoController.setPlaceOther(value: "new york")
//        meteoController.tappedRefreshButton(_sender: refreshButton)
//        sleep(1)
        //meteoController.setPlaceLocal(value: "lyon")
        //meteoController.setPlaceOther(value: "new york")
 
    }
    func testPlaceEmptyInChangeViewController() {
        let changeController = ChangeViewController(space: Space())
        let refreshButton: RefreshButton = RefreshButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), style: .valid, name: "")
        changeController.setCurrencyData(value: "JPY")
        changeController.tappedRefreshButton(_sender: refreshButton)
        sleep(1)
    }
}
