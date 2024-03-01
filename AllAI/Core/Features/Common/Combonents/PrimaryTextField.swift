//
//  PrimaryTextField.swift
//  AllAI
//
//  Created by hosam abufasha on 29/02/2024.
//

import SwiftUI

struct PrimaryTextField: View {
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
//        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        TextField(
            placeholder,
            text: $text,
            axis: .vertical
        )
      
        .padding(16)
//        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

//#Preview {
//    PrimaryTextField()
//}
