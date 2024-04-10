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
    @State var isDarkMode: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Learning Topics", selection: $selectedCase) {
                        ForEach(SwifFulChapters.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.inline)
                }
            }
        }
        
        VStack {
            HStack {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
            }
            
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .fullScreenCover(isPresented: $showingSheet) {
                getView(for: selectedCase)
            }
        }
        .padding()
        
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
        case .asyncLet:
            AnyView(AsyncLetSwiftUIView())
        case .useTaskGroup:
            AnyView(UseTaskGroupSwiftUIView())
        case .useContinuation:
            AnyView(CheckContinuationSwiftUIView())
        case .structVsClassVsActor:
            AnyView(ActorClassStructSwiftUIView())
        case .animationLearnSwiftUI:
            AnyView(AdvancedSwiftUIAnimation())
        case .polygonAnimation1:
            AnyView(Example2PolygonAnimation())
        }
        
        
    }
    
}
    

#Preview {
    ContentView()
}
