//
//  ContentView.swift
//  NonIsolatedViewModels
//
//  Created by Rhys Morgan on 06/04/2026.
//

import SwiftUI

nonisolated struct Person: Equatable {
  var name: String
  var age: Int
}

@Observable
nonisolated final class ViewModel {
  var person: Person?
  var isLoading = false
  let personLoader: () async -> Person

  init(personLoader: @escaping @concurrent () async -> Person) {
    self.personLoader = personLoader
  }

  func didTapFetchPerson() async {
    isLoading = true
    defer { isLoading = false }
    self.person = await personLoader()
  }
}

struct ContentView: View {
  @State private var viewModel = ViewModel(
    personLoader: {
      try? await Task.sleep(for: .seconds(2))
      return Person(name: "Rhys", age: 31)
    }
  )

  @State private var loadingID: UUID?

  var body: some View {
    VStack {
      if let person = viewModel.person {
        Text("\(person.name) is \(person.age) years old")
        Button("Reset") {
          viewModel.person = nil
        }
      } else {
        Button("Fetch Person") {
          loadingID = UUID()
        }
      }
    }
    .task(id: loadingID) {
      if loadingID != nil {
        await viewModel.didTapFetchPerson()
      }
    }
    .padding()
    .overlay {
      if viewModel.isLoading {
        ProgressView("Updating")
          .padding()
          .glassEffect(.regular, in: .rect(cornerRadius: 8))
      }
    }
  }
}

#Preview {
  ContentView()
}
