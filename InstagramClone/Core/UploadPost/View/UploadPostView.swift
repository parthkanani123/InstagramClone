//
//  UploadPostView.swift
//  InstagramClone
//
//  Created by parth kanani on 18/04/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View 
{
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View
    {
        VStack
        {
            // action toolbar
            HStack
            {
                // from our MainTabView, we click on plus icon to upload post, we select image, write caption, but we don't want to upload that so we click on cancel, so when we click on cancel, we reset all the properties. and we want to get back to our MainTabView, specifically on FeedView, and our FeedView has tabIndex 0 so, we are going to set tabIndex = 0.
                Button(action: {
                    ClearPostDataAndReturnToFeed()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Text("New post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    Task
                    {
                        try await viewModel.uploadPost(caption: caption)
                        ClearPostDataAndReturnToFeed()
                    }
                }, label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                })
            }
            .padding(.horizontal)
            
            // post image and caption
            HStack(spacing: 8)
            {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                // by adding vertical axis, in textField if we type long text than it goes to new line.
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear(perform: {
            imagePickerPresented.toggle()
        })
        // when we click on any image from photoPicker, our selectedImage is set to that image on which we have click and whenever it set, it call function loadImage.
        .photosPicker(isPresented: $imagePickerPresented,
                      selection: $viewModel.selectedImage)
    }
    
    func ClearPostDataAndReturnToFeed()
    {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
