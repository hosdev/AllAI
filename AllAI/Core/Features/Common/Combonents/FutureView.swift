//
//  FutureView.swift
//  AllAI
//
//  Created by hosam abufasha on 23/02/2024.
//

import SwiftUI

struct FutureView<Content : View ,  ModelType: Codable >: View {
    
    let response: ApiResponse<ModelType>
    let successView: (_ data : ModelType)-> Content
    let errorView: ((_ error : Error)-> Content)?
    let loadingView: (()-> Content)?
    
    init(response: ApiResponse<ModelType>,
    @ViewBuilder successView:  @escaping (_: ModelType) -> Content,
    @ViewBuilder errorView: @escaping (_: Error) -> Content,
    @ViewBuilder loadingView: @escaping () -> Content) {
        self.response = response
        self.successView = successView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    init(response: ApiResponse<ModelType>,
    @ViewBuilder successView:  @escaping (_: ModelType) -> Content,
    @ViewBuilder errorView: @escaping (_: Error) -> Content
    ) {
        self.response = response
        self.successView = successView
        self.errorView = errorView
        self.loadingView = nil
    }
    
    init(response: ApiResponse<ModelType>,
    @ViewBuilder successView:  @escaping (_: ModelType) -> Content,
    @ViewBuilder loadingView: @escaping () -> Content
    ) {
        self.response = response
        self.successView = successView
        self.errorView = nil
        self.loadingView = loadingView
    }
    
    init(response: ApiResponse<ModelType>,
    @ViewBuilder successView:  @escaping (_: ModelType) -> Content
    ) {
        self.response = response
        self.successView = successView
        self.errorView = nil
        self.loadingView = nil
    }
    
    var body: some View {
        switch response.status {
        case .loading:
            loadingView?()
            if loadingView == nil {
                ProgressView()
            }
        case .completed(let data):
            successView(data)
        case .failed(let error):
            errorView?(error)
            if errorView == nil {
                Text(error.localizedDescription)
            }
        }
    }
}

