//
//  EditProfileViewModel.swift
//  InstagramClone
//
//  Created by parth kanani on 27/04/24.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject
{
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(from: selectedImage)
            }
        }
    }
    
    init(user: User)
    {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    @Published var fullname = ""
    @Published var bio = ""
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    
    func loadImage(from item: PhotosPickerItem?) async
    {
        guard let item = item else {
            return
        }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {
            return
        }
        
        guard let uiImage = UIImage(data: data) else {
            return
        }
        
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws
    {
        // update profile image if changed
       
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname
        {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio
        {
            data["bio"] = bio
        }
        
        if !data.isEmpty
        {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
