//
//  SwiftfulThinkingChapters.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 11/28/23.
//

import Foundation

enum SwifFulChapters: Int,CaseIterable {
    case startLearn
    case doTryCatchThrows
    case imageDownloadAsyncAwait
}

extension SwifFulChapters {
    var title: String {
        switch self {
        case .startLearn:
            return "Start Learn"
        case .doTryCatchThrows:
            return "Do-Try-Catch-Throws"
        case .imageDownloadAsyncAwait:
            return "Download Images With Async/Await, @escaping and Combine"
        }
        
    }
}
