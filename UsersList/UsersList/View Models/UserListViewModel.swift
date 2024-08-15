//
//  UserListViewModel.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String? = nil
    
    init() {
      fetchUsers()
    }
    
    func fetchUsers() {
        errorMessage = nil
        
        guard let url = URL(string: "https://randomuser.me/api/?page=1&results=20&seed=abc") else {
            errorMessage = "Invalid URL"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    self?.errorMessage = "Failed to fetch users: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    self?.users = decodedResponse.results
                } catch {
                    self?.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }

        task.resume()

    }
}
