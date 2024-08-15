//
//  UserCache.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

protocol UserCacheProtocol {
    func getCachedUsers(for page: Int) -> [User]?
    func cache(users: [User], for page: Int)
}

class UserCache: UserCacheProtocol {
    private let cache = NSCache<NSNumber, NSArray>()
    
    func getCachedUsers(for page: Int) -> [User]? {
        return cache.object(forKey: NSNumber(value: page)) as? [User]
    }
    
    func cache(users: [User], for page: Int) {
        cache.setObject(users as NSArray, forKey: NSNumber(value: page))
    }
}

