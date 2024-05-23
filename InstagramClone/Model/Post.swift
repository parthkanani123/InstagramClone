//
//  Post.swift
//  InstagramClone
//
//  Created by parth kanani on 17/04/24.
//

import Foundation
import Firebase

// Identifiable :- we confirm to Identifiable so that we can display these things in a list with swiftUI.
// Hashable :- we confirm to Hashable so that we can make these things navigatable like when we want to use navigationDestination,so              we need to confirm to Hashable.
// Codable :- when we need to upload information to our server and download information from our server to create our posts

struct Post: Identifiable, Hashable, Codable
{
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp // Firebase doesn't accept Date() object, so we have to use this custom Firebase's Timestamp object. it basically did the same thing that the Date() do. Timestamp() gives the time at the moment of uploading post.
    var user: User?
}

extension Post
{
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for now",
              likes: 123,
              imageUrl: "batman2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[0]),
        
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Iron man",
              likes: 12,
              imageUrl: "ironman2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[2]),
        
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Wakanda Forever",
              likes: 104,
              imageUrl: "blackpanther2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[3]),
        
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Venom is hungry, Time to eat",
              likes: 314,
              imageUrl: "venom2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[1]),
        
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Hey, this is spidy",
              likes: 46,
              imageUrl: "spiderman2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[4]),
        
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Hey, this is spidy",
              likes: 65,
              imageUrl: "spiderman",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[4]),
    ]
}
