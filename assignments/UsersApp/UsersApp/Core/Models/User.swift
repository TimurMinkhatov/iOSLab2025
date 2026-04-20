//
//  User.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

struct User: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let username: String
}
