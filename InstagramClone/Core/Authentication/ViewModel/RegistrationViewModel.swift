//
//  RegistrationViewModel.swift
//  InstagramClone
//
//  Created by parth kanani on 26/04/24.
//

import Foundation

// RegistrationViewModel contains all the properties needed for sign up(email, password, username), that get set throughout the registration flow

class RegistrationViewModel: ObservableObject
{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        // we reset all the properties because when we sign out and click on signIn we see that the fields have previous entered value in the same userSession, if we have remove and open app again then it doesn't shows previous values.
        username = ""
        email = ""
        password = ""
    }
}

