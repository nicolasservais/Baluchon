//
//  MeteoTests.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 24/09/2021.
//

import XCTest
@testable import Baluchon
class MeteoTests: XCTestCase {
    
//    var meteo: MeteoService!

/*    override func setUp() {
        super.setUp()
        URLSessionMock.loadingHandler = { request in
            let response: HTTPURLResponse = MockResponseData.responseOK
            let error: Error? = nil
            let data: Data? = MockResponseData.meteoCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionMock.self]
        let session = URLSession(configuration: configuration)
        meteo = MeteoService(urlSession: session)
    }
*/
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
        meteoService.getMeteo(lieu: "lyon"){ (success, weatherResult) in
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
        meteoService.getMeteo(lieu: "lyon"){ (success, weatherResult) in
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
        meteoService.getMeteo(lieu: "lyon"){ (success, weatherResult) in
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
        meteoService.getMeteo(lieu: "lyon"){ (success, weatherResult) in
        // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    
    }
    /*    func testGetQuoteShouldPostFailedCallbackIfError() {
            // Given
            let meteoService = MeteoService(urlSession: URLSessionDataTaskFake(data: nil, response: nil, error: FakeResponseData.error))
            //let meteoService = MeteoService(urlSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
            //let quoteService = QuoteService(
            //    quoteSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            //    imageSession: URLSessionFake(data: nil, response: nil, error: nil))

            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            //quoteService.getQuote { (success, quote) in
            meteoService.getWeather(lieu: "", callback: { (success, meteo) in
            // Then
                XCTAssertFalse(success)
                XCTAssertNil(meteo)
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }
        func testGetQuoteShouldPostFailedCallbackIfNoData() {
            let meteoService = MeteoService(urlSession: URLSessionDataTaskFake(data: nil, response: nil, error: nil))
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            meteoService.getWeather(lieu: "", callback: { (success, meteo) in
            // Then
                XCTAssertFalse(success)
                XCTAssertNil(meteo)
                expectation.fulfill()
            })
         }
        func testGetQuoteShouldPostFailedCallbackIfIncorrectResponse() {
            // Given
            let meteoService = MeteoService(urlSession: URLSessionDataTaskFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseKO, error: nil))
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            meteoService.getWeather(lieu: "", callback: { (success, meteo) in
            // Then
                XCTAssertFalse(success)
                XCTAssertNil(meteo)
                expectation.fulfill()
            })
        }
        func testGetQuoteShouldPostFailedCallbackIfIncorrectData() {
            // Given
            let meteoService = MeteoService(urlSession: URLSessionDataTaskFake(data: FakeResponseData.quoteIncorrectData, response: FakeResponseData.responseOK, error: nil))
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            meteoService.getWeather(lieu: "", callback: { (success, meteo) in
            // Then
                XCTAssertFalse(success)
                XCTAssertNil(meteo)
                expectation.fulfill()
            })
        }
     */
     /*   func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
            // Given
            let meteoService = MeteoService(urlSession: URLSessionDataTaskFake(data: FakeResponseData.quoteCorrectData, response: FakeResponseData.responseOK, error: nil))
            //let expectation = XCTestExpectation(description: "Wait for queue change.")
            meteoService.getWeather(lieu: "", callback: { (success, meteo) in
            // Then
                print("success : ",success)
                XCTAssertFalse(success)
                XCTAssertNotNil(meteo)
                //expectation.fulfill()
            })
            //wait(for: [expectation], timeout: 0.01)
        }
    */
    
    /*override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */

}
