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
            .navigationTitle("Async Let1")
            .onAppear{
                Task {
                    do {
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchImage5 = fetchImage()
                        
                        let (image1, image2, image3, image4, image5) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4, try fetchImage5)
                        self.images.append(contentsOf: [image1, image2, image3, image4, image5])
                        
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
