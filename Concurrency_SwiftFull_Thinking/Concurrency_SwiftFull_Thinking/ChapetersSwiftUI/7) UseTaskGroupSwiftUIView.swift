//
//  UseTaskGroupSwiftUIView.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 1/12/23.
//

import SwiftUI

class TaskGroupDataManager {
    
    func fetchImageUsingAsyncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/300")
        
        let (image1, image2, image3, image4) = await(try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        return [image1, image2, image3, image4]
        
    }
    
    private func fetchImage(urlString: String ) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}

class UseTaskGroupSwiftUIViewModel: ObservableObject {
    @Published var imagesToShow: [UIImage] = []
    let manager = TaskGroupDataManager()
    
    func getImages() async {
        if let images = try? await manager.fetchImageUsingAsyncLet() {
            await MainActor.run {
                imagesToShow.append(contentsOf: images)
            }
            
        }
    }
}
struct UseTaskGroupSwiftUIView: View {
    @StateObject private var viewModel = UseTaskGroupSwiftUIViewModel()
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
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
        .frame(minWidth: 44, minHeight: 44, alignment: .topLeading)
        .padding()
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.imagesToShow, id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
        }
        .task {
            await viewModel.getImages()
        }
    }
}

#Preview {
    UseTaskGroupSwiftUIView()
}
