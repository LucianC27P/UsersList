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
                
                List(viewModel.users) { user in
                    UserRowView(user: user)
                }
                .background(Color.white)
                .listStyle(PlainListStyle())
                .cornerRadius(0)
            }
            .padding(0)
        }
    }
}

#Preview {
    UserListView()
}
