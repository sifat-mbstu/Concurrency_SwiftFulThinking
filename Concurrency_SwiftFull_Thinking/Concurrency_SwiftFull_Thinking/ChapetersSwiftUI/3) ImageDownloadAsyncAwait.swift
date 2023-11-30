//
//  3) ImageDownloadAsyncAwait.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/30/23.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    private func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    func downloadEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> () ) {
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self else { return }
            let image = handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError( { $0 } )
            .eraseToAnyPublisher()
    }
}

class ImageDownloadAsyncAwaitViewModel: ObservableObject {
    
    @Published var imageToShow: UIImage? = UIImage(systemName: "heart.fill")
    let loader = DownloadImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    func fetchImage() {
        
        loader.downloadEscaping { [weak self] image, error in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                imageToShow = image
            }
        }
    }
    
    func fetchImageWithCombine() {
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("In Sink")
            } receiveValue: { [weak self] image in
                guard let self else { return }
                imageToShow = image
            }
            .store(in: &cancellables)

    }
}

struct ImageDownloadAsyncAwait: View {
    
    @StateObject private var viewModel = ImageDownloadAsyncAwaitViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            if let image = viewModel.imageToShow {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                        viewModel.fetchImageWithCombine()
                    }
            }
            Button(action: {
                dismiss()
            }, label: {
                Text("Back")
                    .padding()
                    
            })
            .background(.black)
            .foregroundColor(.white)
            .frame(minWidth: 44, minHeight: 44, alignment: .leading)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .onAppear {
            viewModel.fetchImageWithCombine()
        }
    }
}

#Preview {
    ImageDownloadAsyncAwait()
}
