//
//  NonIsolatedViewModelsApp.swift
//  NonIsolatedViewModels
//
//  Created by Rhys Morgan on 06/04/2026.
//

import SwiftUI

@main
struct NonIsolatedViewModelsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(
        viewModel: ViewModel(
          personLoader: PersonLoader {
            try? await Task.sleep(for: .seconds(2))
            return Person(name: "Rhys", age: 31)
          }
        )
      )
    }
  }
}
