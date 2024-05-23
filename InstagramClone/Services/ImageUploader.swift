//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by parth kanani on 27/04/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader
{
    // we can't upload swiftUI image to firebase, so we are uploading UIImage
    // once the image done uploading to firebase storage, we can get back the imageURL or the location of that image which is what we are going to store in out database.
    static func uploadImage(image: UIImage) async throws -> String?
    {
        /* we are compressing image because imagine if an image is the size of entire screen like it's massive image, it's like wallpaper 4K image, we don't want to upload that entire image to firebase storage. we are going to compress it quite a bit and profile images are oftentimees very small so we can compress them even more. PostImage and ProfileImage have their own compression quality */
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
