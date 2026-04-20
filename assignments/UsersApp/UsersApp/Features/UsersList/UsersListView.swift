//
//  UsersListView.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import SwiftUI
import UIComponents

struct UsersListView: View {
  @State private var viewModel: UsersListViewModel

  init(service: UsersService) {
    _viewModel = State(wrappedValue: UsersListViewModel(service: service))
  }

  var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading {
          LoadingView(message: "Загрузка...")
        } else if let error = viewModel.errorMessage {
          VStack(spacing: 12) {
            Text("Ошибка: \(error)")
              .multilineTextAlignment(.center)
            Button("Повторить") {
              Task { await viewModel.loadUsers() }
            }
          }
          .padding()
        } else {
          List(viewModel.users) { user in
            NavigationLink(value: user) {
              HStack(spacing: 12) {
                AsyncImageView(
                  url: URL(string: "https://i.pravatar.cc/150?u=\(user.id)"),
                  size: 44)
                UserCardView(
                  name: user.name,
                  username: user.username,
                  email: user.email)
              }
            }
            .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
          }
        }
      }
      .navigationTitle("Пользователи")
      .navigationDestination(for: User.self) { user in
        ProfileControllerWrapper(user: user)
          .ignoresSafeArea()
      }
      .task {
        await viewModel.loadUsers()
      }
      .onDisappear {
        viewModel.cancelLoading()
      }
    }
  }
}
