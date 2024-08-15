//
//  UserService.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(page: Int, useCache: Bool, completion: @escaping (Result<[User], Error>) -> Void)
}

class UserService: UserServiceProtocol {
    private let baseURL = "https://randomuser.me/api/"
    private let cache: UserCacheProtocol
    
    init(cache: UserCacheProtocol = UserCache()) {
        self.cache = cache
    }
    
    func fetchUsers(page: Int, useCache: Bool = true, completion: @escaping (Result<[User], any Error>) -> Void) {
        // Check the cache first if useCache is true
        if useCache, let cachedUsers = cache.getCachedUsers(for: page) {
            completion(.success(cachedUsers))
            return
        }
        
        let resultsOnPage = 20
        let urlString = "\(baseURL)?page=\(page)&results=\(resultsOnPage)&seed=abc"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("JSON Response: \(jsonString)")
//            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                let users = response.results
                
                // Cache the results if useCache is true
                if useCache {
                    self?.cache.cache(users: users, for: page)
                }
                
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

