//
//  AppError.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import Foundation

enum ApiError: String , Error , LocalizedError{
    case jsonDecoding
    case response
    case noInternet
    case cancled
    case failed
    var errorDescription: String?{
        switch self {
        case .jsonDecoding:
            "Json decoading error"
        case .response:
            "Response error"
        case .noInternet:
            "No Internet"
        case .cancled:
            "Cancelled"
        case .failed:
            "Failed to call"
        }
    }
}
