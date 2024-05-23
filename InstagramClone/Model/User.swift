//
//  User.swift
//  InstagramClone
//
//  Created by parth kanani on 17/04/24.
//

import Foundation
import Firebase

struct User: Identifiable, Codable, Hashable
{
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String // we can't allow user to change email, that's why we used let - constant
    
    // in the profileView we have two button Edit Profile and Follow. so if the profile is of currentUser then we are going to show edit profile button else follow button.
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return false
        }
        
        // if currentUid matches with id that means this is the currentUser so return true else false
        return currentUid == id
    }
    
    var posts: Int
}

extension User
{
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, 
              username: "batman",
              profileImageUrl: nil,
              fullname: "Bruce Wayne",
              bio: "Gotham's Dark Knight",
              email: "batman@gmail.com", posts: 0),
        
        .init(id: NSUUID().uuidString,
              username: "venom",
              profileImageUrl: nil,
              fullname: "Eddie Brock",
              bio: "venom",
              email: "venom@gmail.com", posts: 0),
        
        .init(id: NSUUID().uuidString,
              username: "ironman",
              profileImageUrl: nil,
              fullname: "Tony Stark",
              bio: "Playboy & Billionarie",
              email: "ironman@gmail.com", posts: 0),
        
        .init(id: NSUUID().uuidString,
              username: "blackpanther",
              profileImageUrl: nil,
              fullname: "Wakanda forever",
              bio: "Gotham's Dark Knight",
              email: "blackpanther@gmail.com", posts: 0),
        
        .init(id: NSUUID().uuidString,
              username: "spiderman",
              profileImageUrl: nil,
              fullname: "Peter Parker",
              bio: "Test bio",
              email: "spiderman@gmail.com", posts: 0)
    ]
}
