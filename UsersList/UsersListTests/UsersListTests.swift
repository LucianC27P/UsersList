//
//  UsersListTests.swift
//  UsersListTests
//
//  Created by Lucian Cristea on 15.08.2024.
//

import XCTest
@testable import UsersList

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockUserService: MockUserService!
    var userFactory: UserListMockDataFactory!

    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        userFactory = UserListMockDataFactory()
        viewModel = UserListViewModel(userService: mockUserService)
    }

    override func tearDown() {
        viewModel = nil
        mockUserService = nil
        userFactory = nil
        super.tearDown()
    }

    func test_loadMoreUsersIfNeeded_success() {
        let expectedUsers = userFactory.getListOfUsers()
        mockUserService.result = .success(expectedUsers)
        viewModel = UserListViewModel(userService: mockUserService)
        
        viewModel.loadMoreUsersIfNeeded(currentItem: nil, useCache: false)
        
        let expectation = XCTestExpectation(description: "Users should be loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            XCTAssertFalse(self.viewModel.users.isEmpty, "Users array should not be empty.")
            XCTAssertEqual(self.viewModel.users.count, expectedUsers.count, "The users loaded by the view model should match the expected users from the JSON file.")
            XCTAssertNil(self.viewModel.errorMessage, "The error message should be nil if fetching users succeeded.")
            XCTAssertFalse(self.viewModel.isLoading, "The view model should not be loading after fetching users.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_loadMoreUsersIfNeeded_failed() {
        let mockError = UserServiceError.unknownError
        mockUserService.result = .failure(mockError)
        
        viewModel.loadMoreUsersIfNeeded(currentItem: nil, useCache: false)
        
        let expectation = XCTestExpectation(description: "Error should be handled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            XCTAssertTrue(self.viewModel.users.isEmpty, "Users array should be empty if fetching failed.")
            XCTAssertNotNil(self.viewModel.errorMessage, "An error message should be set if fetching users failed.")
            XCTAssertFalse(self.viewModel.isLoading, "The view model should not be loading after an error.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}

