//
//  AppError.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import Foundation

enum ApiError: String , Error{
    case jsonDecoding
    case response
    case noInternet
    case cancled
    case failed
}
