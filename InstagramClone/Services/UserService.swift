//
//  UserService.swift
//  InstagramClone
//
//  Created by parth kanani on 27/04/24.
//

import Foundation
import Firebase

struct UserService
{
    static func fetchUser(withUid uid: String) async throws -> User
    {
        // we goto firestore database, in that we go to users collection, in that collection we goto document of currentUid and, get all the data related to that currentUid.
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        
        // DECODING:
        return try snapshot.data(as: User.self)
    }
    
    
    // here we are fetching all the users from firebase and returning the array of User
    static func fetchAllUser() async throws -> [User]
    {
        var users = [User]()
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let documents = snapshot.documents
        
        for doc in documents
        {
            guard let user = try? doc.data(as: User.self) else {
                return users
            }
            
            users.append(user)
        }
        
        return users
    }
    
    // Another way of fetching all users
    /*
     @MainActor
     static func fetchAllUser() async throws -> [User]
     {
         let snapshot = try await Firestore.firestore().collection("users").getDocuments()
         return snapshot.documents.compactMap {
             try? $0.data(as: User.self)
         }
     }
     */
}
