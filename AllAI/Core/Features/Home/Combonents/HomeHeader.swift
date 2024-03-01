//
//  HomeHeader.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import SwiftUI

struct HomeHeader: View {
    let  user : User
    
    var body: some View {
        let radius: CGFloat = 25
        HStack{
            VStack(alignment: .leading) {
                Text("Hi \(user.name)").font(.callout)
                Text("Welcome Back 🔥").font(Font(CTFont(.application, size: 23))).fontWeight(.bold)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(.primary)
                    .frame(width: radius * 2, height: radius * 2)
                if(user.photo != nil)
                {
                    AsyncImage(url: user.photo!){img in
                        img.image?
                            .resizable()
                            .scaledToFill()
                    }.frame(width: 4.0.squareRoot() * radius, height: 4.0.squareRoot() * radius)
                        .clipShape(Circle())
                }
                else {
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 4.0.squareRoot() * radius, height: 4.0.squareRoot() * radius)
                        .clipShape(Circle())
                }
            }
            
        }
    }
}



//#Preview {
//    HomeHeader()
//}
