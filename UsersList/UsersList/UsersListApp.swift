//
//  UsersListApp.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import SwiftUI

@main
struct UsersListApp: App {
    var body: some Scene {
        WindowGroup {
            let userService = UserService()
            let viewModel = UserListViewModel(userService: userService)
            
            UserListView(viewModel: viewModel)
        }
    }
}
