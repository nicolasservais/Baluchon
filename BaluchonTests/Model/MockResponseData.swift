//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 24/09/2021.
//

import Foundation
class MockResponseData {
    // MARK: - Data
    static var meteoCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "MeteoRessource", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "TranslateRessouce", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var convertCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "ConvertRessouce", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let meteoIncorrectData = "erreur".data(using: .utf8)!
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    static let convertIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class MeteoError: Error {}
    static let meteoError = MeteoError()
    
    class TranslateError: Error {}
    static let translateError = TranslateError()

    class ConvertError: Error {}
    static let convertError = ConvertError()
}
