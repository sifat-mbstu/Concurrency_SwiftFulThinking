//
//  ContentView.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedCase: SwifFulChapters = .startLearn
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Learning Topics", selection: $selectedCase) {
                        ForEach(SwifFulChapters.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
        }
        VStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .fullScreenCover(isPresented: $showingSheet) {
                getView(for: selectedCase)
            }
        }
        .padding()
    }
    
    func getView(for currentChapter: SwifFulChapters) -> some View {
        switch currentChapter {
        case .startLearn:
            AnyView(LearningTopicsView())
        case .doTryCatchThrows:
            AnyView(DoCatchTryThrows())
        case .imageDownloadAsyncAwait:
            AnyView(ImageDownloadAsyncAwait())
        case .useOfAsyncAwait:
            AnyView(HowToUseAsyncAwait())
        case .useTask:
            AnyView(HowToUseTask())
        }
        
        
    }
    
}

#Preview {
    ContentView()
}
