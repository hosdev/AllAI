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
    
    static func call(
        config :HttpUrlConfig,
        path: String,
        method: HttpMethod,
        authorizedToken: String? = nil ,
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
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("true", forHTTPHeaderField: "x-mock-match-request-body")
        
        if let  httpBody {
            request.httpBody = try? JSONEncoder().encode(httpBody)
        }
    
        if let authorizedToken {
            request.addValue("Bearer \(authorizedToken)", forHTTPHeaderField: "Authorization")
        }
      
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return .success((data, response))
        } catch  {
            return .failure(error)
        }
    }
}
