//
//  3) ImageDownloadAsyncAwait.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/30/23.
//

import SwiftUI

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    func downloadEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard 
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil,error)
                return
            }
            completionHandler(image, nil)
        }
        .resume()
    }
}

class ImageDownloadAsyncAwaitViewModel: ObservableObject {
    
    @Published var imageToShow: UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    
    func fetchImage() {
        imageToShow = UIImage(systemName: "heart.fill")
        loader.downloadEscaping { [weak self] image, error in
            DispatchQueue.main.async { [weak self] in 
                guard let self else { return }
                imageToShow = image
            }
        }
    }
}

struct ImageDownloadAsyncAwait: View {
    
    @StateObject private var viewModel = ImageDownloadAsyncAwaitViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button("back") {
                dismiss()
            }
            .background(.yellow)
            .position(x: 10, y: 10)
            .frame(width: 100, height: 44, alignment: .center)
        }
        ZStack {
            
            if let image = viewModel.imageToShow {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            viewModel.fetchImage()
        }
    }
}

#Preview {
    ImageDownloadAsyncAwait()
}
