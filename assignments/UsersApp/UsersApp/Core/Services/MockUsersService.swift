//
//  MockUsersService.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import Foundation

final class MockUsersService: UsersService {
  var shouldFail = false
  var mockUsers: [User] = [
    User(id: 1, name: "Alice Johnson", email: "alice@mail.com", phone: "123-456", username: "alice"),
    User(id: 2, name: "Bob Smith", email: "bob@mail.com", phone: "789-012", username: "bob"),
    User(id: 3, name: "Carol White", email: "carol@mail.com", phone: "345-678", username: "carol")
  ]

  func fetchUsers() async throws -> [User] {
    if shouldFail { throw URLError(.notConnectedToInternet) }
    return mockUsers
  }

  func fetchUser(id: Int) async throws -> User {
    if shouldFail { throw URLError(.notConnectedToInternet) }
    guard let user = mockUsers.first(where: { $0.id == id }) else {
      throw URLError(.badURL)
    }
    return user
  }

  func cancelAll() {}
}
