//
//  BaluchonUITests.swift
//  BaluchonUITests
//
//  Created by Nicolas SERVAIS on 14/10/2021.
//

import XCTest

class BaluchonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        

        
        let app = XCUIApplication()
        app.launch()
        
        //Test MeteoPage
        XCUIDevice.shared.orientation = .landscapeLeft
        app.buttons["meteo"].tap()
        sleep(1)
        XCUIDevice.shared.orientation = .portrait
        
        //Test translatePage
        app.tabBars["Tab Bar"].buttons["Translate"].tap()
        app.scrollViews.otherElements.textFields["french"].tap()
        app.scrollViews.otherElements.textFields["french"].typeText("Demain")
        XCUIApplication().keyboards.buttons["Return"].tap()
        app.buttons["translate"].tap()
        sleep(1)
        let translate = app.scrollViews.otherElements.textFields["english"].value as! String
        XCUIDevice.shared.orientation = .landscapeLeft
        app.scrollViews.otherElements.textFields["english"].tap()
        app.scrollViews.otherElements.textFields["english"].typeText("Yesterday")
        XCUIApplication().keyboards.buttons["Return"].tap()
        app.buttons["translate"].tap()
        XCUIDevice.shared.orientation = .portrait

        app.scrollViews.otherElements.textFields["english"].tap()
        app.scrollViews.otherElements.textFields["english"].typeText(String(XCUIKeyboardKey.delete.rawValue))
        XCUIApplication().keyboards.buttons["Return"].tap()
        app.buttons["translate"].tap()
        if app.alerts.element.collectionViews.buttons["OK"].exists { app.tap() }
        
        XCUIDevice.shared.orientation = .landscapeLeft
        app.scrollViews.otherElements.textFields["french"].tap()
        app.scrollViews.otherElements.textFields["french"].typeText(String(XCUIKeyboardKey.delete.rawValue))
        XCUIApplication().keyboards.buttons["Return"].tap()
        app.buttons["translate"].tap()
        if app.alerts.element.collectionViews.buttons["OK"].exists { app.tap() }

        //Test changePage
        XCUIDevice.shared.orientation = .portrait
        app.tabBars["Tab Bar"].buttons["Change"].tap()
        app.scrollViews.otherElements.textFields["euro"].tap()
        app.scrollViews.otherElements.textFields["euro"].typeText("10")

        app.toolbars["Toolbar"].buttons["Convert"].tap()
        let convert = app.scrollViews.otherElements.textFields["dollar"].value as! String
        
        app.buttons["change"].tap()
        app.scrollViews.otherElements.textFields["euro"].tap()
        app.scrollViews.otherElements.textFields["euro"].typeText("10..")
        if app.alerts.element.collectionViews.buttons["OK"].exists { app.tap() }
        app.toolbars["Toolbar"].buttons["Convert"].tap()

        app.scrollViews.otherElements.textFields["dollar"].tap()
        XCUIDevice.shared.orientation = .landscapeRight
        app.scrollViews.otherElements.textFields["dollar"].typeText("20")
        app.toolbars["Toolbar"].buttons["Convert"].tap()
        app.scrollViews.otherElements.textFields["dollar"].tap()
        app.scrollViews.otherElements.textFields["dollar"].typeText("10..")
        app.toolbars["Toolbar"].buttons["Convert"].tap()
        XCUIDevice.shared.orientation = .portrait
        if app.alerts.element.collectionViews.buttons["OK"].exists { app.tap() }
        app.scrollViews.otherElements.textFields["dollar"].tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()
        app.scrollViews.otherElements.textFields["euro"].tap()
        app.toolbars["Toolbar"].buttons["Cancel"].tap()

        XCTAssertEqual(translate, "Tomorrow")
        XCTAssertEqual(convert, "10.90")
  
    }
}
