//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Nicolas SERVAIS on 24/09/2021.
//

import Foundation
class MockResponseData {

    // MARK: - Bad Json Data
    static var meteoBadData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "MeteoRessourceBad", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translateBadData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "TranslateRessourceBad", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var changeBadData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "ChangeRessourceBad", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    // MARK: - Data
    static var meteoCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "MeteoRessource", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "TranslateRessource", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var changeCorrectData: Data? {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "ChangeRessource", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let meteoIncorrectData = "erreur".data(using: .utf8)!
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    static let changeIncorrectData = "erreur".data(using: .utf8)!

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

    class ChangeError: Error {}
    static let changeError = ChangeError()
}
