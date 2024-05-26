//
//  11) AdvancedSwiftUIAnimation.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 29/12/23.
//

import SwiftUI

struct AdvancedSwiftUIAnimation: View {
    @State private var half = false
    @State private var dim = false
    @Environment (\.dismiss) private var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("Back")
                .padding()
            
        })
        .background(.black)
        .foregroundColor(.white)
        .frame(minWidth: 44, minHeight: 44, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        
        Image("tea") 
            .scaleEffect(half ? 0.05 : 0.1)
            .opacity(dim ? 0.2 : 1.0)
//            .animation(.easeInOut(duration: 0.5), value: dim)
            .onTapGesture {
                self.half.toggle()
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.dim.toggle()
                }
            }
            
    }
}


