//
//  OnboardingScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import SwiftUI



struct OnboardingScreen: View {
    
    //MARK: - Properties
    private var model : OnboardingModel = .init(datasource: HttpClient.shared)
    @State private var obList: ApiResponse<[Onboarding]> = .init(status: .loading)
    @State private  var selection = 0
    @State private var isLoginPresented = false
    
    
    //MARK: - Views
    var body: some View {
        NavigationStack {
            FutureView(response: obList) { data in
                VStack {
                    TabView(selection: $selection){
                        ForEach(data.indices, id: \.self) { index in
                            let ob  = data[index]
                            VStack(){
                                AsyncImage(url: URL(string: ob.image)){image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                }  placeholder: {
                                    ProgressView()
                                } .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width, alignment: .center)
                                
                                Text(ob.title)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                    .frame(height: 40)
                            }.padding().tag(index)
                        }
                     
                    }
                    .tabViewStyle(.page)
                    barItems(showStart:  selection == data.count - 1)
                }
            }.navigationDestination(isPresented: $isLoginPresented) {LoginScreen()}
        }.task {
            getData()
        }
        
    }
    
    
    func barItems(showStart: Bool) ->  some View {
        return Group {
            if  showStart {
                Button{ isLoginPresented.toggle() } label: {
                    Text( "Start")
                        .padding(.horizontal, 50)
                        .padding(.vertical, 0)
                        .foregroundColor(.white)
                }  .buttonStyle(.borderedProminent).controlSize(.large).padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
            } else {
                Button(action: {
                    withAnimation(.easeInOut) {onNext()}
                }){Image(systemName: "arrow.forward").padding(10) }            .buttonStyle(.borderedProminent).controlSize(.large)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
            }
        }
    }

    
    
    
    //MARK: - Logic
    private func getData() {
        Task { @MainActor in
            obList = await model.getOnboardingListAction()
        }
    }
    private func onNext() {
        switch obList.status {
        case .loading:
            break
        case .completed(let data):
            if  selection < data.count - 1 {
                self.selection += 1
            }
        case .failed(_):
            break
        }
    }
    
}



#Preview {
    OnboardingScreen()
}

