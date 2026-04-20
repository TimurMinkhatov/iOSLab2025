//
//  ProfileControllerWrapper.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import SwiftUI

struct ProfileControllerWrapper: UIViewControllerRepresentable {

    let user: User

    func makeUIViewController(context: Context) -> ProfileViewController {
        ProfileViewController(user: user)
    }

    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        uiViewController.configure(with: user)
    }
}
