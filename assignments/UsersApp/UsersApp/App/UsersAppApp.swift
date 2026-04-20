//
//  UsersAppApp.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import SwiftUI

@main
struct UsersAppApp: App {
    private let service: UsersService = RealUsersService()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.usersService, service)
        }
    }
}
