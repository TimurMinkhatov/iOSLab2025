//
//  UsersCache.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

actor UsersCache {
    private var storage: [Int: User] = [:]

    func user(for id: Int) -> User? {
        storage[id]
    }

    func save(_ user: User) {
        storage[user.id] = user
    }

    func contains(id: Int) -> Bool {
        storage[id] != nil
    }
}
