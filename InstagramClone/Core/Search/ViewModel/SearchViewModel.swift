//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by parth kanani on 27/04/24.
//

import Foundation

class SearchViewModel: ObservableObject
{
    @Published var searchText = ""
    @Published var users = [User]()
    
    var searchedUser: [User] 
    {
        guard !searchText.isEmpty else {
            return users
        }
        
        return users.filter { $0.username.localizedCaseInsensitiveContains(searchText)}
    }
    
    @MainActor
    func fetchAllUser() async throws
    {
        self.users = try await UserService.fetchAllUser()
    }
}
