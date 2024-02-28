//
//  LoginScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 27/02/2024.
//

import SwiftUI


struct LoginScreen: View {
    
    //MARK: - Properties
    @Environment(AuthAppModel.self) var authApp : AuthAppModel
    @State var username: String = ""
    @State var password: String = ""
    @State var loading: Bool = false
    @State var error: Error?
    
    
    //MARK: - Views
    var body: some View {
        ZStack(alignment: .top){
            LottieView(loopMode: .loop,fileName: "login_animation",animationSpeed: 1)
                .blur(radius: 0).frame(
                    width: 100,
                    height: 500).scaleEffect(0.3)
                .ignoresSafeArea()
            Rectangle()
                .fill(Color.gray.opacity(0.1)).ignoresSafeArea()
            
            VStack {
                //Image("app_logo_white").resizable().aspectRatio(contentMode: .fit).padding(40)
                Spacer()
                Text("Welcome!".localized)
                    .font(Font(CTFont(.system, size: 30)))
                    .fontWeight(.thin)
                
                    .padding(.bottom,5)
                Text("Sign In To Continue".localized)
                    .font(Font(CTFont(.system, size: 30)))
                    .fontWeight(.semibold)
                
                    .padding(.bottom,50)
                if loading  {ProgressView()}
                else {
                    VStack(alignment: .center){
                        
                        SocialButton(image: "apple", text: "Sign in with Apple", color: Color.black,textColor: Color.white){
                            authApp.loginWithApple { result in
                                loading.toggle()
                                switch result {
                                case .success(let success):
                                    break
                                case .failure(let failure):
                                    error = failure
                                }
                                loading.toggle()
                            }
                        }
                        Spacer().frame(height: 20)
                        SocialButton(image: "google", text: "Sign in with Google", color: Color.white,textColor: Color.black){
                            authApp.loginWithGoogle{ result in
                                loading.toggle()
                                switch result {
                                case .success(let success):
                                    break
                                case .failure(let failure):
                                    error = failure
                                }
                                loading.toggle()
                            }
                        }
                    }
                    
                }
            }
            .alert("Error",isPresented: .init(get: {
                error != nil
            }, set: { b in
                error = nil
            }),  actions: {
                
            },message: {
                Text(error?.localizedDescription ?? "Error occuered")
            })
            .padding(30)
            .frame(alignment: .bottom )
        }
    }
    
}



//#Preview {
//    LoginScreen()
//}
