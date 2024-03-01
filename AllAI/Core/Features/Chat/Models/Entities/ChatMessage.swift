//
//  ChatMessage.swift
//  AllAI
//
//  Created by hosam abufasha on 01/03/2024.
//

import Foundation

struct ChatMessage : Identifiable , Hashable{
    let text : String
    let id : UUID
    let owner : String
    let date : Date
}
