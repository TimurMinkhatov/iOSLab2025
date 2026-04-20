//
//  UsersAppTests.swift
//  UsersAppTests
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import XCTest
@testable import UsersApp

final class UsersViewModelTests: XCTestCase {

    func testLoadUsersSuccess() async {
        let service = MockUsersService()
        let viewModel = await UsersListViewModel(service: service)

        await viewModel.loadUsers()

        let users = await viewModel.users
        let isLoading = await viewModel.isLoading
        XCTAssertEqual(users.count, 3)
        XCTAssertFalse(isLoading)
    }

    func testLoadUsersError() async {
        let service = MockUsersService()
        service.shouldFail = true
        let viewModel = await UsersListViewModel(service: service)

        await viewModel.loadUsers()

        let errorMessage = await viewModel.errorMessage
        let users = await viewModel.users
        XCTAssertNotNil(errorMessage)
        XCTAssertTrue(users.isEmpty)
    }

    func testLoadUsersEmpty() async {
        let service = MockUsersService()
        service.mockUsers = []
        let viewModel = await UsersListViewModel(service: service)

        await viewModel.loadUsers()

        let users = await viewModel.users
        XCTAssertTrue(users.isEmpty)
    }
}
