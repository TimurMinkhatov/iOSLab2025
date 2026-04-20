//
//  UsersService.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

protocol UsersService {
  func fetchUsers() async throws -> [User]
  func fetchUser(id: Int) async throws -> User
  func cancelAll()
}
