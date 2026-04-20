//
//  UsersListViewModel.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class UsersListViewModel {
  var users: [User] = []
  var isLoading = false
  var errorMessage: String?

  private let service: UsersService

  init(service: UsersService) {
    self.service = service
  }

  func loadUsers() async {
    isLoading = true
    errorMessage = nil

    do {
      users = try await service.fetchUsers()
    } catch is CancellationError {
      isLoading = false
      return
    } catch {
      errorMessage = error.localizedDescription
    }

    isLoading = false
  }

  func cancelLoading() {
    service.cancelAll()
  }
}
