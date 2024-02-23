//
//  OnboardingScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 21/02/2024.
//

import SwiftUI



struct OnboardingScreen: View {
    
    @Dependency(\.features.onboardingFeature.getOnboardingUseCase) var getOnboardingUseCase
    
    var body: some View {
        OnboardingBody(getOnBoardingUseCase: getOnboardingUseCase)
    }
    

}


private struct OnboardingBody : View {
    @StateObject var viewModel : OnboardingViewModel
    @State var isLoginPresented = false
    
    init(getOnBoardingUseCase: GetOnboardingUseCase) {
        self._viewModel = StateObject(wrappedValue: .init(getOnBoardingUseCase: getOnBoardingUseCase))
    }
    
    var body: some View {
        
        
        
        NavigationStack {
            viewByStatus().navigationDestination(isPresented: $isLoginPresented) {Text("Hii")}
        }.task {
            viewModel.getData()
        }
        
    }
    
    func barItems(showStart: Bool) -> some View {
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
                    withAnimation(.easeInOut) {viewModel.onNext()}
                }){Image(systemName: "arrow.forward").padding(10) }            .buttonStyle(.borderedProminent).controlSize(.large)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0))
            }
        }
    }
    
    
    @ViewBuilder
    func viewByStatus() -> some View {
        switch viewModel.obList.status {
        case .loading:
            ProgressView()
        case .completed(let model):
            VStack {
                TabView(selection: $viewModel.selection){
                    // 3 observer for selection
                    ForEach(model) { ob in
                        VStack(){
                            Image(ob.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width, alignment: .center)
                            
                            Text(ob.title)
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                            
                       
                            Spacer()
                                .frame(height: 40)
                        }.padding().tag(ob)}}
                .tabViewStyle(.page)
                barItems(showStart:  viewModel.selection == model.count - 1)
            }
        case .failed(let error):
            Text(error.localizedDescription)
        }
    }
}


#Preview {
    OnboardingScreen()
}
