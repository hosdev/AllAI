//
//  CustomSocialButton.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import SwiftUI

struct SocialButton: View {
    var image: String
    var text: String
    var color: Color
    var textColor: Color
    var action: (() -> ())?
    
    var body: some View{
        HStack{
            Button(
                action: {
                    action?()
                },
                label: {
                    HStack{
                        Image(image)
                            .frame(width:32, height: 32)
                         
                    
                        Text(text)
                            .bold()
                            .foregroundColor(textColor).scaledToFill()
                        
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 10).fill(color))
                })
        }
    }
}

#Preview {
    SocialButton(image: "apple", text: "Sign in with Apple", color: Color.black,textColor: Color.white)
}
