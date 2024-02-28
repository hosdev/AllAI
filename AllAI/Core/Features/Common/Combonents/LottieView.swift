//
//  LottieView.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import SwiftUI
import Lottie

struct LottieView : UIViewRepresentable {
    let loopMode: LottieLoopMode
    let fileName: String
    let animationSpeed: CGFloat
    init(loopMode: LottieLoopMode, fileName: String, animationSpeed: CGFloat = 1.0) {
        self.loopMode = loopMode
        self.fileName = fileName
        self.animationSpeed = animationSpeed
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: fileName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        
        animationView.contentMode = .scaleAspectFit
        
        return animationView
    }
}


