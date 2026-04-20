//
//  ContentView.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.usersService) private var service

    var body: some View {
        UsersListView(service: service)
    }
}
