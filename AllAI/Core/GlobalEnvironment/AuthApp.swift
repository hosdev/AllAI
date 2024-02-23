//
//  Auth.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import Foundation
import AuthenticationServices

struct Credentials {
    var accessToken: String?
    var refreshToken: String?
}

class AuthApp: ObservableObject {
    
   // private let keychain: KeyChain = .init()
    var credentials:Credentials?
    
    @Published  var loggedIn: Bool = false
    
     init() {
        loggedIn = hasAccessToken()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            accessToken: nil,
            refreshToken: nil
        )
    }
    
    func setCredentials(accessToken: String, refreshToken: String) {
//        keychain.set(accessToken, forKey: KeychainKey.accessToken.rawValue)
//        keychain.set(refreshToken, forKey: KeychainKey.refreshToken.rawValue)
 
        loggedIn = true
    }
    
    func hasAccessToken() -> Bool {
        return getCredentials().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }

    func getRefreshToken() -> String? {
        return getCredentials().refreshToken
    }

    func logout() {
//        keychain.removeObject(forKey: KeychainKey.accessToken.rawValue)
//        keychain.removeObject(forKey: KeychainKey.refreshToken.rawValue)
        loggedIn = false
    }
    
    
}
