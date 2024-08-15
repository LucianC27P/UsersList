//
//  UserRowView.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    var timeFormatted : String? {
        DateFormatter.time(from: user.registered?.date ?? "N/A")
    }
    
    var body: some View {
        HStack {
            if let pictureURL = user.picture?.thumbnail, let url = URL(string: pictureURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            } else if let firstNameInitial = user.name?.first?.first {
                Text(String(firstNameInitial))
                    .foregroundColor(.primary)
                    .frame(width: 50, height: 50)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("\(user.name?.first ?? "") \(user.name?.last ?? "")")
                    .font(.body)
                Text(user.email ?? "No email")
                    .font(.subheadline)
                    .foregroundColor(Color.customGray4)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 4) {
                Text(timeFormatted ?? "")
                    .font(.footnote)
                    .foregroundColor(Color.customGray6)
                Button(action: {
                    // Handle favorite action
                    print("favorite")
                }) {
                    Image(systemName: "star")
                        .font(.subheadline)
                        .foregroundColor(Color.customGray6)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
