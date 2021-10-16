//
//  TranslateTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 14/10/2021.
//

import XCTest
@testable import Baluchon
class TranslateTests: XCTestCase {

    func testGetTranslateShouldPostFailedCallbackIfResponseError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = nil
            let data: Data? = MockResponseData.translateCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = MockResponseData.translateError
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
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
        let translateService = TranslateService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
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
        let translateService = TranslateService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfBadData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.translateBadData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertFalse(success)
            XCTAssertEqual(result, "")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }

    func testGetTranslateShouldPostOkCallbackIfCorrectData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.translateCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(urlSession: session)

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "bonjour", lang: "fr-en"){ (success, result) in
        // Then
            XCTAssertTrue(success)
            XCTAssertEqual(result, "Good morning")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testTranslateGetURLFailedIfHostEmpty() {
        // Given
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(urlSession: session)
        // When
        let url = translateService.getTranslateURL(text: "bonjour", lang: "fr-en", host: "")
        // Then
        XCTAssertEqual(url.relativeString, "./")
    }

}
