//
//  DemistifySwiftUI.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 10/4/24.
//

import SwiftUI

final class Dog: ObservableObject {
    let dogTagID: String
    @Published var isAdopted: Bool
    let name: String
    init(dogTagID: String, isAdopted: Bool, name: String) {
        self.dogTagID = dogTagID
        self.isAdopted = isAdopted
        self.name = name
    }
}

final class DemistifySwiftViewModel: ObservableObject {
    @Published var rescueDogs: [Dog]
    @Published var adoptedDogs: [Dog]
    var allDogs: [Dog]
    init(allDogs: [Dog]) {
        self.allDogs = allDogs
        self.rescueDogs = DemistifySwiftViewModel.getDogs(allDogs: allDogs, adopted: false)
        self.adoptedDogs = DemistifySwiftViewModel.getDogs(allDogs: allDogs, adopted: true)
    }
    
    static func getDogs(allDogs: [Dog], adopted: Bool) -> [Dog] {
        var dogs: [Dog] = []
        for aDog in allDogs {
            guard aDog.isAdopted == adopted else { continue }
            dogs.append(aDog)
        }
        return dogs
    }
    
    static func getDogs() -> [Dog] {
        var alldogs : [Dog] = []
        for _ in 0..<10 {
            let aDog = Dog(dogTagID: UUID().uuidString, isAdopted: Bool.random(), name: randomString(length: 1))
            alldogs.append(aDog)
        }
        
        return alldogs
        func randomString(length: Int) -> String {
            let letters = "🐵🐒🦍🐶🐕🐩🐺🦊🦝🐈🦁🐅🐎"
            return String((0..<length).map{ _ in letters.randomElement()! })
        }
    }
}

struct DemistifySwiftUI: View {
    @ObservedObject var model: DemistifySwiftViewModel
    var body: some View {
        List {
            Section {
                ForEach(model.rescueDogs, id: \.dogTagID) { rescueDog in
                    ProfileView(dog: rescueDog)
                        .onTapGesture {
                            rescueDog.isAdopted = true
                            model.rescueDogs = DemistifySwiftViewModel.getDogs(allDogs: model.allDogs, adopted: false)
                            model.adoptedDogs = DemistifySwiftViewModel.getDogs(allDogs: model.allDogs, adopted: true)
                        }
                }
            }
            Section {
                ForEach(model.adoptedDogs, id: \.dogTagID) { adoptedDog in
                    ProfileView(dog: adoptedDog)
                        .onTapGesture {
                            adoptedDog.isAdopted = false
                            model.rescueDogs = DemistifySwiftViewModel.getDogs(allDogs: model.allDogs, adopted: false)
                            model.adoptedDogs = DemistifySwiftViewModel.getDogs(allDogs: model.allDogs, adopted: true)
                        }
                }
            }
        }
    }
}

struct ProfileView: View {
    @ObservedObject var dog: Dog
    var body: some View {
        Text(dog.name + " " + dog.dogTagID)
    }
}

#Preview {
    DemistifySwiftUI(model: DemistifySwiftViewModel(allDogs: DemistifySwiftViewModel.getDogs()))
}
