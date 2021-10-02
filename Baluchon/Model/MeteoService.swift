//
//  QuoteService.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 23/09/2021.
//

import Foundation
struct Weather {
    var name: String
    var temp: Float
}
struct Coord: Codable {
    let lon: Float
    let lat: Float
}
struct global: Codable {
    let name: String
    let timezone: Int
    let coord: Coord
}
class MeteoService {
    
    // MARK: - Singleton pattern
    static var shared = MeteoService()
    private init() {}

    //private static let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    //private let quoteUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=7f56e99d43347757e34b56dc724c4f14")!
    //private static let pictureUrl = URL(string: "https://source.unsplash.com/random/1000x1000")!
    
    private var task: URLSessionDataTask?
    private var meteoSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
    //task = urlSession
        meteoSession = urlSession
    }

    func getMeteo(lieu: String, callback: @escaping (Bool, Weather?) -> Void) {
        let request: URLRequest = createMeteoRequest()
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
                    let weather: Weather = Weather(name: parsedJSON.name, temp: parsedJSON.coord.lat)
                    callback(true, weather)
                    return
                } catch {
                    callback(false, nil)
                    return
                    }
               }
        }
        task?.resume()
    }
    private func update(quote: global) {
        //quoteLabel.text = quote.text
        //authorLabel.text = quote.author
        //imageView.image = UIImage(data: quote.imageData)
    }
    private func createMeteoRequest() -> URLRequest {
        var request = URLRequest(url: getMeteoURL(lon: 0, lat: 0))
        request.httpMethod = "GET"
        //let body = "method=getQuote&lang=en&format=json"
        //let body = "q=lyon&appid=7f56e99d43347757e34b56dc724c4f14"
        //request.httpBody = body.data(using: .utf8)
        return request
    }
    private func getMeteoURL(lon: Float, lat: Float) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: "7f56e99d43347757e34b56dc724c4f14"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "q", value: "lyon")
        ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        return url
//        let meteoUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=7f56e99d43347757e34b56dc724c4f14")!
//        return meteoUrl
    }
}
