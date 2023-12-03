//
//  CheckContinuationSwiftUIView.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 3/12/23.
//

import SwiftUI

class CheckedContinuationViewNetworkManager {
    
    typealias continuationType = CheckedContinuation<UIImage, Error>
    func getData(url: URL) async throws -> Data {
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func getDataUsingContinuation(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    continuation.resume(returning: data)
                } else if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func getHeartImageFromDatabase(completionHandler: @escaping ( (_ image: UIImage) -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageUsingContinuation() async -> UIImage {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let image = UIImage(systemName: "heart.fill")!
                continuation.resume(returning: image)
            }
        }
    }
}

class CheckedContinuationViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let networkManager = CheckedContinuationViewNetworkManager()
    private let url = URL(string: "https://picsum.photos/300")
    func getImage() async {
        guard let url else { return }
        
        do {
            let data = try await networkManager.getData(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    func getImageUsingContinuation() async {
        guard let url else { return }
        
        do {
            let data = try await networkManager.getDataUsingContinuation(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getHeartImage() {
        networkManager.getHeartImageFromDatabase { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    func getHeartImage() async {
        let image =  await networkManager.getHeartImageUsingContinuation()
        await MainActor.run {
            self.image = image
        }
    }
    
    
}

struct CheckContinuationSwiftUIView: View {
    
    @StateObject private var viewModel = CheckedContinuationViewModel()
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
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        Task {
                            await viewModel.getImageUsingContinuation()
                        }
                    }
            }
        }
        .task {
             await viewModel.getHeartImage()
        }
    }
}

#Preview {
    CheckContinuationSwiftUIView()
}
