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
    
    // MARK: - Singleton pattern
    static var shared = MeteoService()
    private init() {}

    private var task: URLSessionDataTask?
    private var meteoSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
        meteoSession = urlSession
    }

    func getMeteo(place: String, callback: @escaping (Bool, Meteo?) -> Void) {
        let request: URLRequest = createMeteoRequest(name: place)
        task?.cancel()
        task = meteoSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
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
                    //let meteo: Meteo = Meteo(temperature: 33.0, icon: "")
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
    private func createMeteoRequest(name: String) -> URLRequest {
        var request = URLRequest(url: getMeteoURL(name: name))
        request.httpMethod = "GET"
        return request
    }
    private func getMeteoURL(name: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: Key.meteo), // "7f56e99d43347757e34b56dc724c4f14"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: name)
        ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        return url
    }
}
