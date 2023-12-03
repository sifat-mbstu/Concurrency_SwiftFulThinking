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
    case useOfAsyncAwait
    case useTask
    case asyncLet
    case useTaskGroup
    case useContinuation
}

extension SwifFulChapters {
    var title: String {
         var titleString =
        switch self {
        case .startLearn:
            "Start Learn"
        case .doTryCatchThrows:
            "Do-Try-Catch-Throws"
        case .imageDownloadAsyncAwait:
            "Download Images With Async/Await, @escaping and Combine"
        case .useOfAsyncAwait:
            "How to use async/await keyword in Swift"
        case .useTask:
            "How to use Task and .task in Swift"
        case .asyncLet:
            "How to use Async Let to perform concurrent methods in Swift"
        case .useTaskGroup:
            "How to use TaskGroup to perform concurrent Tasks in Swift"
        case .useContinuation:
            "How to use Continuations in Swift (withCheckedThrowingContinuation)"
        }
        titleString = "Concurrency #\(self.rawValue): \(titleString)"
        return titleString
    }
}
