//
//  EnvironmentKey.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 17/04/2026.
//

import SwiftUI

private struct UsersServiceKey: EnvironmentKey {
  static let defaultValue: UsersService = RealUsersService()
}

extension EnvironmentValues {
  var usersService: UsersService {
    get { self[UsersServiceKey.self] }
    set { self[UsersServiceKey.self] = newValue }
  }
}
