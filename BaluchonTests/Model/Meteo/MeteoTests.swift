//
//  MeteoTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 24/09/2021.
//

import XCTest
@testable import Baluchon
class MeteoTests: XCTestCase {

    func testGetMeteoShouldPostFailedCallbackIfResponseError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = nil
            let data: Data? = MockResponseData.meteoCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfError() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseKO
            let error: Error? = MockResponseData.meteoError
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfNoData() {
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
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfIncorrectResponse() {
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
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfBadData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.meteoBadData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }

    func testGetMeteoShouldPostOkCallbackIfCorrectData() {
        // Given
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.meteoCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let meteoService = MeteoService(urlSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        meteoService.getMeteo(place: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testGetMeteoURLFailedIfHostEmpty() {
        // Given
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        let meteoService = MeteoService(urlSession: session)
        // When
        let url = meteoService.getMeteoURL(name: "lyon", host: "")
        // Then
        XCTAssertEqual(url.relativeString, "./")
    }
    func testGetCancelButton() {
        let button: RefreshButton = RefreshButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), style: .roundedBlue, name: "nil")
        button.changeButton(style: .error, animating: true)
        button.changeButton(style: .valid, animating: false)
        button.changeButton(style: .error, animating: false)
        button.changeButton(style: .roundedBlueRotate, animating: false)
    }

}
