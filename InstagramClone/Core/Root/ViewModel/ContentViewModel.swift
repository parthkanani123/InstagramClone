//
//  ContentViewModel.swift
//  InstagramClone
//
//  Created by parth kanani on 19/04/24.
//

import Foundation
import Firebase
import Combine

@MainActor
class ContentViewModel: ObservableObject
{
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>() // cancellables is a collection used to manage the lifetime of subscriptions to Combine publishers, ensuring they are canceled when no longer needed.
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers()
    {
        // userSession is published property in AuthService and our ContentViewModel is subscribed to AuthService and that published property - userSession and it receives the userSession using combine.
        // setupSubscribers function is listen to changes on userSession and .sink function gives us the new value that we get back and we are able to then set our userSession property of ContentViewModel that's coming back from the AuthService
        service.$userSession.sink { [weak self] userSession in
                self?.userSession = userSession
        }
        .store(in: &cancellables) //  This ensures that the subscription is automatically canceled when the ContentViewModel instance is deallocated, preventing potential memory leaks.
        
        service.$currentUser.sink { [weak self] currentUser in
                self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
