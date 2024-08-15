//
//  UserListView.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserListViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UserListView()
}
