//
//  HttpClient.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import Foundation


typealias CompletionHandler = (Data) -> Void
typealias FailureHandler = (Error) -> Void


struct HttpUrlConfig {
    let scheme: String
    let host: String
}


enum HttpMethod: String {
    case get
    case put
    case delete
    case post
}

class HttpClient {
    
    static let shared = HttpClient()
   private init( ) {}
    
    var defaultHeaders : [String:String] = [
        "Content-Type":"application/json",
        "Accept":"application/json",
        "lang":"en"
        ]
    
     func call(
        config :HttpUrlConfig,
        path: String,
        method: HttpMethod,
        
        queryItems: [URLQueryItem]? = nil,
        httpBody: Encodable? = nil
    ) async -> Result<(data:Data, response:URLResponse),Error>{
        var components = URLComponents()
        components.scheme = config.scheme
        components.host = config.host
        components.path = path
        
        if  queryItems != nil {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            return .failure(URLError(.badURL))
        }
        
        let accessToken = UserDefaults.standard.string(forKey: UserDefaultsKeys.token)
//        @AppSecureStorage("") var t 
        if accessToken != nil {
             defaultHeaders["Authorization"] = "Bearer \(accessToken!)"
         }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        for head in defaultHeaders {
            request.addValue(head.value, forHTTPHeaderField: head.key)
        }
        if let  httpBody {
            request.httpBody = try? JSONEncoder().encode(httpBody)
        }
        debugPrint(url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return .success((data, response))
        } catch  {
            return .failure(error)
        }
    }
}
