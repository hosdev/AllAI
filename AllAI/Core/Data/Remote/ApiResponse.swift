//
//  ApiResponse.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import Foundation

class ApiResponse<Model:Codable>{
    let status : Status
    let message : String
    let statusCode : Int

    init(status: Status, message: String = "", statusCode: Int = 0) {
        self.status = status
        self.message = message
        self.statusCode = statusCode
    }
    
    enum Status {
    case loading
    case completed(Model)
    case failed(Error)
    }
}
