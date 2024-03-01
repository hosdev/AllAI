//
//  ReversedScrollView.swift
//  AllAI
//
//  Created by hosam abufasha on 01/03/2024.
//

import SwiftUI

struct ReversedScrollView<Content: View>: View {
    var content: Content
    
    init( @ViewBuilder builder: ()->Content) {
        self.content = builder()
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack {
                    Spacer()
                    content
                }
                .frame(minWidth: proxy.size.width)
            }
        }
    }
}
