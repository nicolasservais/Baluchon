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
    // MARK: - Singleton pattern
    static var shared = ChangeService()
    private init() {}

    private var task: URLSessionDataTask?
    private var changeSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
        changeSession = urlSession
    }

    func getChange(currency: String, callback: @escaping (Bool, Double) -> Void) {
        let request: URLRequest = createChangeRequest(name: currency)
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
                    let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                    print("data Change: \(string1)")

                    let parsedJSON = try jsonDecoder.decode(CurrencyRate.self, from: data)
                    //let meteo: Meteo = Meteo(temperature: parsedJSON.main.temp, icon: parsedJSON.weather[0].icon)
                    //let meteo: Meteo = Meteo(temperature: 33.0, icon: "")
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
    private func createChangeRequest(name: String) -> URLRequest {
        var request = URLRequest(url: getChangeURL(name: name))
        request.httpMethod = "GET"
        return request
    }
    private func getChangeURL(name: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: Key.convert),
            URLQueryItem(name: "symbols", value: name) //,AUD,CAD,CHF,CNY,GBP,JPY")
            ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        //print("url \(url)")
        return url
    }
}
