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
    @ViewBuilder
    private func getView(for currentChapter: SwifFulChapters) -> some View {
        switch currentChapter {
        case .startLearn:
            LearningTopicsView()
        case .doTryCatchThrows:
            DoCatchTryThrows()
        case .imageDownloadAsyncAwait:
            ImageDownloadAsyncAwait()
        case .useOfAsyncAwait:
            HowToUseAsyncAwait()
        case .useTask:
            HowToUseTask()
        case .asyncLet:
            AsyncLetSwiftUIView()
        case .useTaskGroup:
            UseTaskGroupSwiftUIView()
        case .useContinuation:
            CheckContinuationSwiftUIView()
        case .structVsClassVsActor:
            ActorClassStructSwiftUIView()
        case .animationLearnSwiftUI:
            AdvancedSwiftUIAnimation()
        case .polygonAnimation1:
            Example2PolygonAnimation()
        case .demistifySwiftUI:
            DemistifySwiftUI(model: DemistifySwiftViewModel(allDogs: DemistifySwiftViewModel.getDogs()))
        }
    }
}

#Preview {
    ContentView()
}
