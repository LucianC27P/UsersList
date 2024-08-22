//
//  UserListMockDataFactory.swift
//  UsersList
//
//  Created by Lucian Cristea on 22.08.2024.
//

import Foundation

class UserListMockDataFactory {
    func getListOfUsers() -> [User] {
        guard let url = Bundle.main.url(forResource: "UserListMockModel", withExtension: "json") else {
            fatalError("Could not find UserListMockModel.json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            fatalError("Failed to load or decode UserListMockModel.json: \(error)")
        }
    }
}
