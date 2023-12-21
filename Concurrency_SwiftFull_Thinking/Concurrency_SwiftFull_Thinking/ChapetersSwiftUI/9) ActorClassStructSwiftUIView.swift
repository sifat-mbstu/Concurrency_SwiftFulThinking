//
//  ActorClassStructSwiftUIView.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 12/21/23.
//

import SwiftUI

struct ActorClassStructSwiftUIView: View {
    var body: some View {
        Text("Hello")
            .onAppear {
                runTest()
            }
    }
    private func runTest() {
        print("Test Started")
        structTest1()
        classTest1()
    }
    private func printDivider() {
        print("""
    -------------------------
    """)
    }
}
#Preview {
    ActorClassStructSwiftUIView()
}
//----Struct-----

struct MyStruct {
    var title: String
}

extension ActorClassStructSwiftUIView {
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting Title!")
        print("Struct:: ObjectA: ", objectA.title)
        
        var objectB = objectA
        print("Struct:: Pass the VALUES of ObjectA to ObjectB")
        print("Struct:: ObjectB: ", objectB.title)
        
        objectB.title = "Second Title"
        print("Struct:: ObjectB Title Changed")
        print("Struct:: ObjectB: ", objectB.title)
        print("Struct:: ObjectA: ", objectA.title)
        printDivider()
    }
}

// --- Class

class MyClass {
    var title: String
    init(title: String) {
        self.title = title
    }
}

extension ActorClassStructSwiftUIView {
    private func classTest1() {
        let objectA = MyClass(title: "Starting Title!")
        print("Class:: ObjectA: ", objectA.title)
        
        let objectB = objectA
        print("Class:: Pass the REFERENCE of ObjectA to ObjectB")
        print("Class:: ObjectB: ", objectB.title)
        
        objectB.title = "Second Title"
        print("Class:: ObjectB Title Changed")
        print("Class:: ObjectB: ", objectB.title)
        print("Class:: ObjectA: ", objectA.title)
    }
}
