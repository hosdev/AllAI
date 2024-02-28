//
//  AppError.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import Foundation

class AppError : Error {
    init(message: String = "Error", status: Status) {
        self.message = message
        self.status = status
    }
    enum Status: String{

    
        case cancled
        case failed
        
      
    }
    let message : String
    let status : Status
}
