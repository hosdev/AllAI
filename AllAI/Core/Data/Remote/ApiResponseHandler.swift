//
//  ApiResponseHandler.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import Foundation

struct ApiResponseHandler<Model:Codable>{
    static func handleResponse(data:Data, response: URLResponse) -> ApiResponse<Model> {
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return .init(status: .failed(ApiError.failed),message: "Error occured")
        }
        
        if let model = try? JSONDecoder().decode(
            Model.self,
            from: data
        ) {
            return .init(status: .completed(model),message: "Success call")
        } else {
            return .init(status: .failed(ApiError.jsonDecoding), message: "Error decoading")
        }
        
    }
}
