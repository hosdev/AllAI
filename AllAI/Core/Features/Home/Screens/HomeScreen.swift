//
//  HomeScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import SwiftUI

struct HomeScreen: View {
    
    private enum Destination: Codable, Hashable {
        case chat
        case voice
        case imageGenerate
    }
    
    //MARK: - Properties
    @Environment(AuthAppModel.self) var authModel: AuthAppModel
    
    //MARK: - Views
    var body: some View {
        
        NavigationStack{
            ScrollView {
                HomeHeader(user: authModel.user!)
                Spacer().frame(height: 20)
                serviceCard(title: "Voice Generate", desc: "Generate voices from your favorite characters", image: "voice_ai",color: .yellow,isWide: true, destination: .chat).foregroundStyle(.black)
                HStack{
                    serviceCard(title: "Chat With Me", desc: "Chat with your favorite friend!", image: "bot_ai", color: .init(hex: "e6e5ff"),isWide: false, destination: .chat).foregroundStyle(.black)
                    serviceCard(title: "Write Email", desc: "Write email for your work", image: "email_ai", color: .init(hex: "5552ff"),isWide: false, destination: .chat).foregroundStyle(.white)
                }.fixedSize(horizontal: false, vertical: true)
                serviceCard(title: "Image Generate", desc: "Generate images and art from text", image: "image_ai",color: .red,isWide: true, destination: .chat).foregroundStyle(.white)
                HStack{
                    serviceCard(title: "Translator", desc: "Translate text to any language", image: "translate_ai", color: .init(hex: "C5EBAA"),isWide: false, destination: .chat).foregroundStyle(.black)
                    serviceCard(title: "Write Email", desc: "Write email for your work", image: "code_ai", color: .indigo,isWide: false, destination: .chat).foregroundStyle(.white)
                }.fixedSize(horizontal: false, vertical: true)
                Spacer().frame(height: 40)
            }
            .padding(.all.subtracting(.bottom))
            .navigationDestination(for: Destination.self) { d in
                switch d {
                case .chat:
                    ChatScreen()
                case .voice:
                    ChatScreen()
                case .imageGenerate:
                    ChatScreen()
                    
                }
            }
        }
        
        
        
    }
    
    @ViewBuilder
    private func serviceCard(title:String, desc:String, image:String, color: Color, isWide: Bool , destination : Destination ) -> some View {
        let content =  VStack{
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: .leading)
            Text(desc)
                .font(.footnote)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        NavigationLink(value: destination){
            Group {
                if(isWide) {
                    HStack(content: {
                        content
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    })
                }
                else{
                    VStack{
                        content.frame(maxHeight: .infinity)
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 10)))
    }
}
//
//#Preview {
//    HomeScreen().environment(AuthAppModel())
//}
