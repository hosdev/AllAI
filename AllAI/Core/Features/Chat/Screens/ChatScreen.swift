//
//  ChatScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 29/02/2024.
//

import SwiftUI
import AVFoundation

struct ChatScreen: View {
  
    //MARK: - Properties
    @State var prompt = ""
    @State var loading  = false
    @Environment(ChatModel.self) var chatModel : ChatModel
    @Environment(AuthAppModel.self) var auth : AuthAppModel
    
    //MARK: - Views
    var body: some View {
        chatContentMessages
        .toolbar(.hidden, for: .tabBar)
        .safeAreaInset(edge: .bottom) {
            bottomField
           }
        .navigationTitle("Chat")
    }
    
    var bottomField : some View {
        VStack{
            Divider()
            HStack{
                PrimaryTextField("Message", text: $prompt)
                Button(action: {
                        AudioServicesPlaySystemSound(1004)
                        Task {
                        let prompt = self.prompt
                            loading.toggle()
                            self.prompt = ""
                            await chatModel.sendMessage(message: prompt)
                            AudioServicesPlaySystemSound(1003)
                            loading.toggle()
                    }
                }, label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 27))
                })
                .disabled(loading || prompt.isEmpty)
                .padding(.horizontal)
            }.padding(.all.subtracting(.top))
        }
        
        .background(.ultraThinMaterial)
        
    }
    
    var chatContentMessages : some View {
        ScrollViewReader{ proxy in
             ScrollView {
                ForEach(chatModel.chatHistory){ message in
                    chatBubble(message: message)
                        .transition(.scale)
                        .id(message.id)
                        .contextMenu(menuItems: {
                            Button("Copy") {
                                UIPasteboard.general.string = message.text
                            }
                            Text(message.date.formatted())
                        })
                }
                if(loading){
                    ProgressView()
                        .transition(.asymmetric(insertion: .scale, removal: .opacity)).id("loading")
                }
               
            }.onChange(of: chatModel.chatHistory.count) { oldValue, newValue in
                withAnimation(.default) {
                    proxy.scrollTo(chatModel.chatHistory.last?.id,anchor: .bottom)
                }
            }
            .onAppear{
                withAnimation(.smooth) {
                    proxy.scrollTo(chatModel.chatHistory.last?.id)
                }
            }
        }
        .padding(.horizontal)
        .scrollDismissesKeyboard(.interactively)
    }
    
    @ViewBuilder 
    func chatBubble(message : ChatMessage) -> some View {
        let isBot = message.owner == "model"
        HStack(alignment: .top){
            if(isBot) {
                Image("bot_ai")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .background(.primary)
                    .clipShape(Circle())
            } else{
                Text(String(auth.user!.name.first!))
                    .padding(.all,1)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color(hex: "5552ff"))
                    .background(.primary)
                    .clipShape(Circle())
            }
            VStack{
                Text(isBot ? "Ai Model" : auth.user!.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text(message.text)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .background(isBot ? Color(hex: "e6e5ff") : Color(hex: "5552ff")).foregroundStyle(isBot ? .black : .white)
        .clipShape(.rect(
            topLeadingRadius: isBot ? 0 : 20,
            bottomLeadingRadius: 20,
            bottomTrailingRadius: isBot ? 20 : 0,
            topTrailingRadius: 20
        ))
    }
    
    //MARK: - Logic
}

#Preview {
    ChatScreen().environment(ChatModel()).environment(AuthAppModel())
}
