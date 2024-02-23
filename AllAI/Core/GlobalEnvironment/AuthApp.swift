//
//  Auth.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import Foundation

struct Credentials {
    var accessToken: String?
    var refreshToken: String?
}

class Auth: ObservableObject {
    
    static let shared: Auth = Auth()
    private let keychain: UserDefaults = UserDefaults.standard
    
    @Published  var loggedIn: Bool = false
    
    private init() {
        loggedIn = hasAccessToken()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            accessToken: "",
            refreshToken: ""
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
