//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by parth kanani on 27/04/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View
{
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User)
    {
        // here we are passing user from EditProfileView to EditProfileViewModel
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View
    {
        VStack
        {
            // toolbar
            VStack
            {
                HStack
                {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }, label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    })
                }
                .padding(.horizontal)
            }
            
            Divider()
            
            // edit profile pick
            PhotosPicker(selection: $viewModel.selectedImage)
            {
                VStack
                {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        CircularProfileImageView(user: viewModel.user,
                                                 size: .large)
                    }
                    
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
            .padding(.vertical, 8)
            
            // edit profile info
            
            VStack
            {
                EditProfileRowView(title: "Name",
                                   placeHolder: "Enter your name",
                                   text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio",
                                   placeHolder: "Enter your bio",
                                   text: $viewModel.bio)
            }
            
            Spacer()
            
        }
    }
}

struct EditProfileRowView: View 
{
    let title: String
    let placeHolder: String
    @Binding var text: String
    
    var body: some View
    {
        HStack
        {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack
            {
                TextField(placeHolder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
