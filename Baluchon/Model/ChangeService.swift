//
//  ChangeService.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 05/10/2021.
//

import Foundation

final class ChangeService {
    struct CurrencyRate: Codable {
        let success: Bool
        let timestamp: Int
        let base: String
        let date: String
        let rates : Rates
    }
    struct Rates: Codable {
        let USD: Double
    }
    private let host: String = "data.fixer.io"
    // MARK: - Singleton pattern
    static var shared = ChangeService()
    private init() {}

    private var task: URLSessionDataTask?
    private var changeSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
        changeSession = urlSession
    }

    func getChange(currency: String, callback: @escaping (Bool, Double) -> Void) {
        let request: URLRequest = createChangeRequest(name: currency, host: host)
        task?.cancel()
        task = changeSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, 0)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, 0)
                    return
                }
                let jsonDecoder = JSONDecoder()
                do {
                    // let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                    // print("data Change: \(string1)")
                    let parsedJSON = try jsonDecoder.decode(CurrencyRate.self, from: data)
                    callback(true, parsedJSON.rates.USD)
                    return
                } catch {
                    callback(false, 0)
                    return
                    }
               }
        }
        task?.resume()
    }
    private func createChangeRequest(name: String, host: String) -> URLRequest {
        var request = URLRequest(url: getChangeURL(name: name, host: host))
        request.httpMethod = "GET"
        return request
    }
    func getChangeURL(name: String, host: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host 
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: Key.convert),
            URLQueryItem(name: "symbols", value: name) //,AUD,CAD,CHF,CNY,GBP,JPY")
            ]
        if let url = urlComponents.url, urlComponents.host != "" {
            return url
        }
        let emptyUrl = URL(fileURLWithPath: "")
        return emptyUrl
    }
}
