//
//  ChangeTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 14/10/2021.
//

import XCTest
@testable import Baluchon
class ChangeTests: XCTestCase {


    func testGetChangeShouldPostFailedCallbackIfResponseError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = nil
            let data: Data? = MockResponseData.changeCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, 0.0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
 
    func testGetChangeShouldPostFailedCallbackIfError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = MockResponseData.changeError
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, 0.0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetChangeShouldPostFailedCallbackIfNoData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, 0.0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetChangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, 0.0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetChangeShouldPostFailedCallbackIfBadData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.changeBadData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, 0.0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetChangeShouldPostOkCallbackIfCorrectData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.changeCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(currency: "USD"){ (success, result) in
        // Then
            XCTAssertTrue(success)
            XCTAssertEqual(result, 1.157803)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testChangeGetURLFailedIfHostEmpty() {
        // Given
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(urlSession: session)
        // When
        let url = changeService.getChangeURL(name: "USD", host: "")
        // Then
        XCTAssertEqual(url.relativeString, "./")
    }
    func testDefaultButtonBar() {
        let textField: UITextField = UITextField()
        textField.addDoneCancelToolbar(onDone: nil, onCancel: nil)
        textField.doneButtonTapped()
        textField.cancelButtonTapped()
    }
    
}
