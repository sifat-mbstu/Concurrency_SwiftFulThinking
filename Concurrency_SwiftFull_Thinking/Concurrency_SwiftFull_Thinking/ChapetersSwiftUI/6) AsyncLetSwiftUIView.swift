//
//  AsyncLetSwiftUIView.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 1/12/23.
//

import SwiftUI

class AsyncLetSwiftUIViewModel: ObservableObject {
    
}

struct AsyncLetSwiftUIView: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    private let url = URL(string: "https://picsum.photos/300")!
    @Environment (\.dismiss) var dismiss
    
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
                    ForEach(images, id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let")
            .onAppear{
                Task {
                    do {
                        let image1 = try await fetchImage()
                        self.images.append(image1)
                        
                        let image2 = try await fetchImage()
                        self.images.append(image2)
                        
                        let image3 = try await fetchImage()
                        self.images.append(image3)
                        
                        let image4 = try await fetchImage()
                        self.images.append(image4)
                        
                        let image5 = try await fetchImage()
                        self.images.append(image5)
                        
                    } catch { }
                }
                
            }
        }
    }
    func fetchImage() async throws -> UIImage {
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

#Preview {
    AsyncLetSwiftUIView()
}
