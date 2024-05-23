//
//  AuthService.swift
//  InstagramClone
//
//  Created by parth kanani on 19/04/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService
{
    // about userSession
    /* we are going to use this userSession to determine if we have a user logged in or not. so basically the functionality that we were going to want here guys, is every time the user opens up the app, if they have logged in and they have a account, we want to take them to the main interface of the appication. if they have signed out or don't currently have an account or have deleted the app from their phone, we want to Route them to the login and signUp portion of the application. so we need to do some view routing or presentation logic to figure out where the app needs to take the user and we are going to base all of that on this userSession property. */
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    /* once we sign up we need to set userSession property, so when we create a user, we are ultimately going to end up setting this userSession property like when you sign up a user, it creates a userSession or user account and we are going to do the same thing when we login, so this is where shared intance comes in because the ContentViewModel is listening for changes on that. it's looking at that service, we need to make sure that we are using the same instance of the service. so for example if i created a completely separate service inside of my RegistrationViewModel, i would have 2 AuthService that exist. the registration guy would set a user session on the instance B, but the ContentViewModel is only listening to instance A, so i need them to share that same instance of the AuthService, so that when the userSession gets set from one place, it take necessary effects when userSession gets populated, mainly in ContentViewModel, because when i sign up user i want the ContentViewModel to get the UserSession guy from the subscriber and ultimately route me to the MainTabView as soon as i sign my user up. */
    static let shared = AuthService()
    
    init()
    {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws
    {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            // we get accessed to error inside the catch block
            print("DEBUG : Failed to log in user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws
    {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            // print("DEBUG: created user...")
            await uploadUserData(uid: result.user.uid, username: username, email: email)
            // print("DEBUG: uploaded user data...")
        } catch {
            // we get accessed to error inside the catch block
            print("DEBUG : Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws
    {
        // Auth.auth().currentUser -> this is code that we get from Firebase. it's going to perform some sort of check to see if we have a user logged in to our application.
        self.userSession = Auth.auth().currentUser
        
        // userSession stores currentUser and we require that currentUser's id
        guard let currentUid = userSession?.uid else {
            return
        }
        
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    func signout()
    {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    // it's private because we are not accessing it outside of this class
    // don't use throws because uploading data is rarely ever goes wrong so less chances of error
    @MainActor
    private func uploadUserData(uid: String, username: String, email: String) async {
        
        let user = User(id: uid, username: username, email: email, posts: 0)
        self.currentUser = user
    
        // ENCODING:
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {
            return
        }
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
