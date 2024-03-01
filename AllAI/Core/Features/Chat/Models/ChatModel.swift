//
//  ChatModel.swift
//  AllAI
//
//  Created by hosam abufasha on 01/03/2024.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

@Observable
class ChatModel {
    
    init() {
        model = GenerativeModel(
            name: "gemini-pro",
            apiKey: APIKey.default,
            generationConfig: GenerationConfig(
                maxOutputTokens: 2000
            )
        )
        chat = model.startChat()
        
    }
    //MARK: - Properties
    enum APIKey {
        // Fetch the API key from `GenerativeAI-Info.plist`
        static var `default`: String {
            guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
            else {
                fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
            }
            if value.starts(with: "_") {
                fatalError(
                    "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
                )
            }
            return value
        }
    }
    var chatHistory : [ChatMessage] = [.init(text: "Great to meet you. What would you like to know?", id: .init(), owner: "model", date: .now)]
    let model : GenerativeModel
    let chat: Chat
    
    
    
    //MARK: - Methods
    func sendMessage(message :String)  async{
        withAnimation {
            chatHistory.append(.init(text: message, id: .init(), owner: "user", date: .now))
        }
        let response = try? await chat.sendMessage(message)
        if let text = response?.text {
            withAnimation {
                chatHistory.append(.init(text: text, id: .init(), owner: "model", date: .now))
            }
        }
    }
}
