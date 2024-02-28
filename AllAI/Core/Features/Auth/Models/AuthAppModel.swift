//
//  Auth.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import GoogleSignIn



@Observable
class AuthAppModel {
    
    init() {
    
    }

    
    //MARK: - Properties
    let appleSignInHelper = AppleSignInHelper()
    var user: User?
    var loggedIn: Bool {
        user != nil
    }
    
    

    
    //MARK: - Methods
    func login(user: User) {
        self.user = user
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.user = nil
    }
    func getCurrentUser(){
        if let u = Auth.auth().currentUser {         
            login(user: User(id: u.uid, name: u.displayName ?? "User", email: u.email, photo: u.photoURL))
        }
    }
    func loginWithGoogle(onDone : @escaping (Result<Bool,Error>)->Void)  {
        GoogleSignInHelper().startSignWithGoogleFlow { res in 
            switch res {
            case .success(let cred):
                let credential = GoogleAuthProvider.credential(withIDToken: cred.idToken, accessToken: cred.accessToken)
                self.loginAction(with: credential) { data in
                        onDone(.success(true))
                        self.login(user: data)
                    } failure: { error in
                        onDone(.failure(error))
                    }
            case .failure(let failure):
                onDone(.failure(failure))
            }
        }
    }
    
    func loginWithApple(onDone : @escaping (Result<Bool,Error>)->Void)  {
        appleSignInHelper.startSignInWithAppleFlow { res in
            switch res {
            case .success(let cred):
                let credential = OAuthProvider.appleCredential(withIDToken: cred.idTokenString, rawNonce: cred.nonce, fullName: cred.appleIDCredential.fullName)
                self.loginAction(with: credential) { data in
                        onDone(.success(true))
                        self.login(user: data)
                    } failure: { error in
                        onDone(.failure(error))
                    }
            case .failure(let failure):
                onDone(.failure(failure))
            }
        }
    }
    
    func loginAction(with  credential : AuthCredential,completion: @escaping (User) -> Void,
                     failure: @escaping (AppError) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().signIn(with: credential as AuthCredential) { (authResult , error) in
            if  (error != nil || authResult == nil) {
                failure(AppError(message: error?.localizedDescription ?? "Error Create Account", status: .failed))
                return
            }
            let u = authResult!.user
            let userModel = User(id: u.uid, name: u.displayName ?? "User", email: u.email, photo: u.photoURL)
            
            do {
                try db.collection("users").document(u.uid).setData( from: userModel, merge: false)
                completion(userModel)
            } catch let error {
                failure(AppError(message: error.localizedDescription , status: .failed))
            }
        }
    }
}
