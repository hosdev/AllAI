//
//  AppleSignInHelper.swift
//  my_budget
//
//  Created by hosam abufasha on 07/10/2023.
//

import AuthenticationServices
import CryptoKit
import Foundation
import AuthenticationServices
import SwiftUI

struct AppleSignResult{
    let appleIDCredential : ASAuthorizationAppleIDCredential
    let nonce : String
    let idTokenString  : String
}


class AppleSignInHelper: NSObject {

    
    fileprivate var currentNonce: String?
    var completion : ( (Result<AppleSignResult , Error>) -> Void )? = nil
    
    
    func startSignInWithAppleFlow(whenComplete : @escaping (Result<AppleSignResult , Error>) -> Void ) {
   

        let nonce = randomNonceString()
        currentNonce = nonce
        completion = whenComplete
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
       
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            return ""
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}



extension AppleSignInHelper: ASAuthorizationControllerDelegate {
    
     func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential ,
            let nonce = currentNonce,
            let appleIDToken = appleIDCredential.identityToken,
            let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
    
            self.completion?(Result.failure(URLError(.cancelled)))
            return
        }
       
        self.completion?(.success(AppleSignResult(appleIDCredential: appleIDCredential, nonce: nonce, idTokenString: idTokenString)))

    
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        self.completion?(Result.failure(error))
    }
    
}
