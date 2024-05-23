//
//  PostService.swift
//  InstagramClone
//
//  Created by parth kanani on 29/04/24.
//

import Foundation
import Firebase

struct PostService
{
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPost() async throws -> [Post]
    {
        let snapshot = try await postsCollection.getDocuments()
        
        // this snapshot gives us back a list of document and we want to apply some sort of mapping to that, because we are trying to take this document data and turn it into post. so anytime you are trying to take one thing and turn it into another thing that's what known as mapping or transformation.
        var posts = try snapshot.documents.compactMap({ document in
            let post = try document.data(as: Post.self)
            return post
        })
        
        // another way of converting each documents into Post and append it to posts array
        // self.posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        
        // here we are fetching all the owner of post through ownerUid
        for i in 0 ..< posts.count
        {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPost(uid: String) async throws -> [Post]
    {
        /* Firestore gives us this filtering capability where we can look at a list of documents or collection of documents and filter them down based on certain conditions. it's awesome because in other backends you might have to fetch all the posts from this list and filter through them client side or the iPhone itself. which is way more work than you need to do, right. what if your app has a million of posts and one user only has two. then you have to fetch a million posts every time you go to user's profile and filter through them just to find the two that you want, firestore gives us this capability on the backend. so firebase is really helpful for us.*/
        // this gives us all the posts which have owneruid equal to uid
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
