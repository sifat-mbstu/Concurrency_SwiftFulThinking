//
//  HowToUseTask.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 1/12/23.
//

import SwiftUI

class HowToUseTaskViewModel: ObservableObject {
    @Published var image1: UIImage? = UIImage(systemName: "doc.fill")
    @Published var image2: UIImage? = UIImage(systemName: "doc.fill")
    private let url = URL(string: "https://picsum.photos/200")!
    private let validResponse = 200...300
    func processResponse(_ data: Data?, _ response: URLResponse?) -> UIImage? {
        guard
            let data,
            let response = response as? HTTPURLResponse,
            validResponse.contains(response.statusCode)
        else { return nil }
        return UIImage(data: data)
    }
    
    func fetchImage1() async {
        do {
            let (imageData, response) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                image1 = processResponse(imageData, response)
                print("image1 Downloaded and showed Successfully :)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchImage2() async {
        do {
            let (imageData, response) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                image2 = processResponse(imageData, response)
                print("image2 Downloaded and showed Successfully :)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct HowToUseTask: View {
    
    @StateObject var viewModel = HowToUseTaskViewModel()
    @Environment (\.dismiss) var dismiss
    @State var fetchTask1: Task<(), Never>? = nil
    @State var fetchTask2: Task<(), Never>? = nil
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
            
            Text("Tap Image")
                .font(.title2)
            if let image = viewModel.image1 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .onTapGesture {
//                        fetchTask1?.cancel()
                        fetchTask1 = Task {
                            await viewModel.fetchImage1()
                        }
                        print("DONE fetchTask1!")
                    }
            }
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .onTapGesture {
//                        fetchTask2?.cancel()
                        fetchTask2 = Task {
                            await viewModel.fetchImage2()
                        }
                        print("DONE fetchTask2!")
                    }
            }
        }
        .task {
            await viewModel.fetchImage1()
            await viewModel.fetchImage2()
        }
//        .onDisappear() {
//            fetchTask1?.cancel()
//            fetchTask2?.cancel()
//        }
        .onAppear {
            /*
             Task {
             await viewModel.fetchImage1()
             await viewModel.fetchImage2()
             }
             
            // MARK: YIELD()
           
             Task(priority: .high) {
             //                try? await Task.sleep(nanoseconds: 2_000_000_000)
             await Task.yield()
             print("1) high:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .userInitiated) {
             print("2) userInitiated:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .none) {
             print("3) none:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .medium) {
             print("4) medium:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .default) {
             print("5) default:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .utility) {
             print("6) utility:: \(Thread.current): \(Task.currentPriority)")
             }
             Task(priority: .low) {
             print("7) LOW:: \(Thread.current ): \(Task.currentPriority)")
             }
             Task(priority: .background) {
             print("8) background:: \(Thread.current): \(Task.currentPriority)")
             }
             
            
            //MARK: Nested Task
            Task(priority: .low) {
                print("Low:: \(Thread.current): \(Task.currentPriority)")
                Task.detached {
                    print("Detached: Low:: \(Thread.current): \(Task.currentPriority)")
                }
                
            }
             */
        }
    }
}

#Preview {
    HowToUseTask()
}
