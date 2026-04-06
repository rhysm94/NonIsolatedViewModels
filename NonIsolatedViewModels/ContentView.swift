//
//  ContentView.swift
//  NonIsolatedViewModels
//
//  Created by Rhys Morgan on 06/04/2026.
//

import SwiftUI

@Observable
// Explicitly marking as nonisolated to prove the point!
nonisolated final class ViewModel {
  var person: Person?
  var isLoading = false

  let personLoader: PersonLoader

  init(personLoader: PersonLoader) {
    self.personLoader = personLoader
  }

  func didTapFetchPerson() async {
    isLoading = true
    defer { isLoading = false }
    self.person = await personLoader.load()
  }
}

struct ContentView: View {
  let viewModel: ViewModel

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
