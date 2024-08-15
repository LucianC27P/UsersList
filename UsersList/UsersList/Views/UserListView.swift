//
//  UserListView.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("Users")
                            .font(.title)
                            .bold()
                        Spacer()
                        Button(action: {
                            // Handle search action
                            print("search")
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List(viewModel.users) { user in
                            UserRowView(user: user)
                                .onAppear {
                                    viewModel.loadMoreUsersIfNeeded(currentItem: user)
                                }
                        }
                        .background(Color.white)
                        .listStyle(PlainListStyle())
                        .cornerRadius(0)
                        
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                        }
                    }
                }
                .padding(0)
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let userService = UserService()
        let viewModel = UserListViewModel(userService: userService)
        UserListView(viewModel: viewModel)
    }
}
