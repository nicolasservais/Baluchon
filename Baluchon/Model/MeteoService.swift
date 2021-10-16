//
//  QuoteService.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 23/09/2021.
//

import Foundation

struct Meteo: Codable {
    let temperature: Double
    let icon: String
}
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
struct Main: Codable {
    let temp: Double
}
struct global: Codable {
    let name: String
    let timezone: Int
    let main: Main
    let weather: [Weather]
}

final class MeteoService {
    private let host: String = "api.openweathermap.org"
    // MARK: - Singleton pattern
    static var shared = MeteoService()
    private init() {}

    private var task: URLSessionDataTask?
    private var meteoSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
        meteoSession = urlSession
    }

    func getMeteo(place: String, callback: @escaping (Bool, Meteo?) -> Void) {
        let request: URLRequest = createMeteoRequest(name: place, host: host)
        task?.cancel()
        task = meteoSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                //let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                //print("meteo data Change: \(string1)")

                guard let data = data, error == nil else {
                    callback(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(global.self, from: data)
                    let meteo: Meteo = Meteo(temperature: parsedJSON.main.temp, icon: parsedJSON.weather[0].icon)
                    callback(true, meteo)
                    return
                } catch {
                    callback(false, nil)
                    return
                    }
               }
        }
        task?.resume()
    }
    private func createMeteoRequest(name: String, host: String) -> URLRequest {
        var request = URLRequest(url: getMeteoURL(name: name, host: host))
        request.httpMethod = "GET"
        print(request)
        return request
    }
    func getMeteoURL(name: String, host: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: Key.meteo), //Need to conform KeyProtocol
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: name)
        ]
        if let url = urlComponents.url, urlComponents.host != "" {
            return url
        }
        let emptyUrl = URL(fileURLWithPath: "")
        return emptyUrl
    }
}
