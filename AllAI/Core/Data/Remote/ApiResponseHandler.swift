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
            GeneralAPIModel<Model>.self,
            from: data
        ) {
            return .init(status: .completed(model.data),message: model.message ?? "Success call")
        } else {
            return .init(status: .failed(ApiError.jsonDecoding), message:  "Error decoading")
        }
        
    }
}

struct GeneralAPIModel<T : Codable>: Codable {
    let status: Bool
    let message: String?
    let data: T
    let errors: [String]?
}
