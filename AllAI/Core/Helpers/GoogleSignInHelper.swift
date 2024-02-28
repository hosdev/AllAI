//
//  GoogleSignInHelper.swift
//  my_budget
//
//  Created by hosam abufasha on 08/10/2023.
//

import Foundation
import GoogleSignIn
import FirebaseCore


struct GoogleSignResult{
    let idToken : String
    let accessToken  : String
}

class GoogleSignInHelper{
    

    
    func startSignWithGoogleFlow ( whenComplete : @escaping (Result<GoogleSignResult , Error>) -> Void )  {

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

       
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController){res,error in
            if let error = error {
                whenComplete(.failure(AppError(message: error.localizedDescription, status: .cancled)))
                return
            }
            
            guard
                let authentication = res?.user,
                let idToken = authentication.idToken
            else {
                whenComplete(.failure(AppError(status: .cancled)))
                return }
            
            let credential = GoogleSignResult(idToken: idToken.tokenString, accessToken: authentication.accessToken.tokenString)
            
            whenComplete(.success(credential))
        }
    }

}

