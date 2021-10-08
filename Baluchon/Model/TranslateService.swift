//
//  TranslateService.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 04/10/2021.
//

import Foundation

struct Translate: Codable {
    let text: [String]
}
final class TranslateService {
    
    // MARK: - Singleton pattern
    static var shared = TranslateService()
    private init() {}

    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)

    init(urlSession: URLSession) {
        translateSession = urlSession
    }

    func getTranslate(text: String, lang: String, callback: @escaping (Bool, String) -> Void) {
        
        let request: URLRequest = createTranslateRequest(text: text, lang: lang)
        task?.cancel()
        task = translateSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false,"")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,"")
                    return
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Translate.self, from: data)
                    callback(true, parsedJSON.text[0])
                    return
                } catch {
                    callback(false, "")
                    return
                    }
               }
        }
        task?.resume()
    }
    private func createTranslateRequest(text: String, lang: String) -> URLRequest {
        var request = URLRequest(url: getTranslateURL(text: text, lang: lang))
        request.httpMethod = "GET"
        return request
    }
    private func getTranslateURL(text: String, lang: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translate.yandex.net"
        urlComponents.path = "/api/v1.5/tr.json/translate"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: Key.translate),
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "lang", value: lang)
        ]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components")
        }
        return url
    }
}
