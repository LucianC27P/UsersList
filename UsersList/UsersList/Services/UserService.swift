//
//  UserService.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

enum UserServiceError: Error {
    case dataError
    case unknownError
}

protocol UserServiceProtocol {
    func fetchUsers(page: Int, useCache: Bool, completion: @escaping (Result<[User], UserServiceError>) -> Void)
}

class UserService: UserServiceProtocol {
    private let baseURL = "https://randomuser.me/api/"
    private let cache: UserCacheProtocol
    
    init(cache: UserCacheProtocol = UserCache()) {
        self.cache = cache
    }
    
    func fetchUsers(page: Int, useCache: Bool = true, completion: @escaping (Result<[User], UserServiceError>) -> Void) {
        // Check the cache first if useCache is true
        if useCache, let cachedUsers = cache.getCachedUsers(for: page) {
            completion(.success(cachedUsers))
            return
        }
        
        let resultsOnPage = 20
        let urlString = "\(baseURL)?page=\(page)&results=\(resultsOnPage)&seed=abc"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                completion(.failure(.dataError))
                return
            }
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                let users = response.results
                
                // Cache the results if useCache is true
                if useCache {
                    self?.cache.cache(users: users, for: page)
                }
                
                completion(.success(users))
            } catch {
                completion(.failure(.unknownError))
            }
        }.resume()
    }
}

