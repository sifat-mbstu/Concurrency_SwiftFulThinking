//
//  HowToUseTask.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 1/12/23.
//

import SwiftUI

class HowToUseTaskViewModel: ObservableObject {
    
}

struct HowToUseTask: View {
    
    @StateObject var viewModel = HowToUseTaskViewModel()
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Back")
                    .padding()
                
            })
            .background(.black)
            .foregroundColor(.white)
            .frame(minWidth: 44, minHeight: 44, alignment: .topLeading)
            .padding()
            
            Text("Hello, World!")
        }
    }
}

#Preview {
    HowToUseTask()
}
