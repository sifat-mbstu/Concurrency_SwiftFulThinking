//
//  GlobalActor.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 3/14/24.
//

import Foundation
import SwiftUI

class GlobalActorBootcampViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    func getData() async {
        
    }
}

struct GlobalActorBootcamp: View {
    @StateObject private var viewModel: GlobalActorBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}
struct GlobalActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorBootcamp()
    }
    
    
}
