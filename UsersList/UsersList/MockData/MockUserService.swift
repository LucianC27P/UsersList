//
//  MockUserService.swift
//  UsersList
//
//  Created by Lucian Cristea on 22.08.2024.
//

import Foundation

class MockUserService: UserServiceProtocol {
    var result: Result<[User], UserServiceError>?

    func fetchUsers(page: Int, useCache: Bool, completion: @escaping (Result<[User], UserServiceError>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(.unknownError))
        }
    }
}
