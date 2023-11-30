//
//  DoCatchTryThrows.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/28/23.
//

import SwiftUI

class DoCatchTryThrowsDataManager {
    private var isActive: Bool {
        Bool.random()
    }
    private let successText: String = "✅ Success! Text Is Found"
    
    func getTitle() -> (title: String?, error: Error?) {
        return isActive ? (successText, nil) : (nil, URLError(.badURL))
    }
    func getTitle2() -> Result<String,Error> {
        return isActive ? .success(successText) : .failure(URLError(.badURL))
    }
    func getTitle3() throws -> String {
        if isActive {
            return successText
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "❄ Not Started Yet ❄"
    let manager = DoCatchTryThrowsDataManager()
    func fetchTitle() {
        let newTitle = manager.getTitle()
        self.text = newTitle.title ?? newTitle.error!.localizedDescription
    }
    
    func fetchTitle2() {
        let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = "⛔\(error.localizedDescription)"
        }
    }
    
    func fetchTitle3() {
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch let error {
            self.text = "⛔\(error.localizedDescription)"
        }
    }
    // Ignoring Error if not need
    func fetchTitle4() {
        if let newTitle = try? manager.getTitle3() {
            self.text = newTitle
        }
    }
    
}

struct DoCatchTryThrows: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button("back") {
                dismiss()
            }
            .background(.yellow)
            .position(x: 10, y: 10)
            .frame(width: 100, height: 44, alignment: .center)
            
            Text(viewModel.text)
                .frame(width: 300, height: 300)
                .background(.black)
                .foregroundColor(.white)
                .onTapGesture {
                    viewModel.fetchTitle3()
                }
        }
    }
}

#Preview {
    DoCatchTryThrows()
}
