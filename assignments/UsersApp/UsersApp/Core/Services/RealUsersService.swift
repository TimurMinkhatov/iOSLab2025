//
//  RealUsersService.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import Foundation

@MainActor
final class RealUsersService: UsersService {
  private let cache = UsersCache()
  private var inFlightTasks: [Int: Task<User, Error>] = [:]
  private var fetchAllTask: Task<[User], Error>?

  func fetchUsers() async throws -> [User] {
    if let existing = fetchAllTask {
      return try await existing.value
    }

    let task = Task<[User], Error> {
      let ids = Array(1...10)
      return try await withThrowingTaskGroup(of: User.self) { group in
        for id in ids {
          group.addTask {
            try await self.fetchUser(id: id)
          }
        }
        var users: [User] = []
        for try await user in group {
          users.append(user)
        }
        return users.sorted { $0.id < $1.id }
      }
    }

    fetchAllTask = task
    defer { fetchAllTask = nil }
    return try await task.value
  }

  func fetchUser(id: Int) async throws -> User {
    if let cached = await cache.user(for: id) {
      return cached
    }

    if let existing = inFlightTasks[id] {
      return try await existing.value
    }

    let task = Task<User, Error> {
      try Task.checkCancellation()
      let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")!
      let (data, _) = try await URLSession.shared.data(from: url)
      try Task.checkCancellation()
      let user = try JSONDecoder().decode(User.self, from: data)
      await self.cache.save(user)
      return user
    }

    inFlightTasks[id] = task
    defer { inFlightTasks.removeValue(forKey: id) }
    return try await task.value
  }

  func cancelAll() {
    fetchAllTask?.cancel()
    fetchAllTask = nil
    for task in inFlightTasks.values {
      task.cancel()
    }
    inFlightTasks.removeAll()
  }
}
