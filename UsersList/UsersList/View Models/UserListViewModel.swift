//
//  UserListViewModel.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation
import Combine

protocol UserListViewModelProtocol: ObservableObject {
    var users: [User] { get }
    func loadMoreUsersIfNeeded(currentItem: User?, useCache: Bool)
}

class UserListViewModel: UserListViewModelProtocol {
    @Published private(set) var users = [User]()
    @Published private(set) var isLoading = false
    @Published var errorMessage: String? = nil
    private var currentPage = 1
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
        loadMoreUsersIfNeeded(currentItem: nil, useCache: true)
    }
    
    func loadMoreUsersIfNeeded(currentItem: User?, useCache: Bool = true) {
        guard !isLoading else { return }
        
        if let currentItem = currentItem {
            let thresholdIndex = users.index(users.endIndex, offsetBy: -3)
            if users.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
                fetchUsers(useCache: useCache)
            }
        } else {
            fetchUsers(useCache: useCache)
        }
    }
    
    private func fetchUsers(useCache: Bool) {
        guard currentPage <= 3 else { return }
        
        isLoading = true
        userService.fetchUsers(page: currentPage, useCache: useCache) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newUsers):
                    self?.users.append(contentsOf: newUsers)
                    self?.currentPage += 1
                case .failure(let error):
                    self?.errorMessage = "Error fetching users: \(error.localizedDescription)"
                }
                self?.isLoading = false
            }
        }
    }
}
