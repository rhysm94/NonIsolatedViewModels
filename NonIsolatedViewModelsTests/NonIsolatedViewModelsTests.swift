//
//  NonIsolatedViewModelsTests.swift
//  NonIsolatedViewModelsTests
//
//  Created by Rhys Morgan on 06/04/2026.
//

import Testing
@testable import NonIsolatedViewModels

struct NonIsolatedViewModelsTests {
  @Test func loadRhys() async throws {
    let viewModel = ViewModel {
      await Task.yield()
      return Person(name: "Rhys", age: 31)
    }

    await viewModel.didTapFetchPerson()

    #expect(viewModel.person == Person(name: "Rhys", age: 31))
  }

  @Test func loadJoe() async throws {
    let viewModel = ViewModel {
      await Task.yield()
      return Person(name: "Joe", age: 31)
    }

    await viewModel.didTapFetchPerson()

    #expect(viewModel.person == Person(name: "Joe", age: 31))
  }
}
