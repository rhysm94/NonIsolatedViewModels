//
//  PersonLoader.swift
//  NonIsolatedViewModels
//
//  Created by Rhys Morgan on 06/04/2026.
//

struct Person: Equatable {
  var name: String
  var age: Int
}

struct PersonLoader {
  let load: @concurrent () async -> Person
}
