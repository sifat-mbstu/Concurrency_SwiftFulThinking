//
//  4) HowToUseAsyncAwait.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 1/12/23.
//

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let title2 = "Title2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title2)
                let title3 = "Title3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthors() async {
        let author1 = "Author1: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(author1)
        }
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 = "Author2: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(author2)
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        }
        
        
    }
    
    func addSomething() async {
        let something1 = "something1: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(something1)
        }
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something2 = "something2: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(something2)
            let something3 = "something3: \(Thread.current)"
            self.dataArray.append(something3)
        }
    }
}

struct HowToUseAsyncAwait: View {
    
    @StateObject var viewModel = AsyncAwaitViewModel()
    @Environment(\.dismiss) var dismiss
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
            
            List {
                ForEach(viewModel.dataArray, id: \.self) { data in
                    Text(data)
                }
            }
            .onAppear {
//                viewModel.addTitle1()
//                viewModel.addTitle2()
                Task {
                    await viewModel.addAuthors()
                    await viewModel.addSomething()
                    let finalText = "Final Text: \(Thread.current)"
                    viewModel.dataArray.append(finalText)
                }
            }
        }
    }
}

#Preview {
    HowToUseAsyncAwait()
}
