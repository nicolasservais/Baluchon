//
//  MeteoTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 24/09/2021.
//

import XCTest
@testable import Baluchon
class MeteoTests: XCTestCase {
    
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
        wait(for: [expectation], timeout: 0.01)
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
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedCallbackIfIncorrectResponse() {
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
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedCallbackIfIncorrectData() {
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
        wait(for: [expectation], timeout: 0.01)
    }
    
}
