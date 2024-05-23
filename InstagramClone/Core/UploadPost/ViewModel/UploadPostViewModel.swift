//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by parth kanani on 18/04/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

// asynchronous task happen in background thread, and once want to update our UI, we want to go back to the main thread, which is where all UI update happen, so for that we have to use @MainActor.
@MainActor
class UploadPostViewModel: ObservableObject
{
    // once we select an image from our photos picker, it's going to load that image and it's going to set this profileImage property, which we are going to use back in our UploadPostView
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(from: selectedImage)
            }
        }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(from item: PhotosPickerItem?) async
    {
        guard let item = item else {
            return
        }
        
        // we are are fetch the data of that selectedImage
        guard let data = try? await item.loadTransferable(type: Data.self) else {
            return
        }
        
        // from data we generate UIImage
        guard let uiImage = UIImage(data: data) else {
            return
        }
        
        self.uiImage = uiImage
        
        // we convert UIImage to swiftUI Image and set postImage = that swiftUI Image
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws
    {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let uiImage = uiImage else {
            return
        }
        
        let postRef = Firestore.firestore().collection("posts").document()
        
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else {
            return
        }
        
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), user: nil)
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { // it encodes or transform our Post object into dictionary
            return
        }
        
        try await postRef.setData(encodedPost)
        print("DEBUG: post")
        // update user's post count
        try await updateUserPostsCount(uid: uid)
        print("DEBUG: post uploaded")
    }
    
    func updateUserPostsCount(uid: String) async throws
    {
        let user = try await UserService.fetchUser(withUid: uid)
        var data = [String: Any]()
        data["posts"] = user.posts + 1
        try await Firestore.firestore().collection("users").document(uid).updateData(data)
    }
}
