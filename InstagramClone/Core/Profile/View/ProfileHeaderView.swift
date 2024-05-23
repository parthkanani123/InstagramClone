//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by parth kanani on 17/04/24.
//

import SwiftUI

struct ProfileHeaderView: View 
{
    let user: User
    @State private var showEditProfile = false
    
    var body: some View
    {
        VStack(spacing: 10)
        {
            // pic and stats
            HStack
            {
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8)
                {
                    UserStateView(value: user.posts, title: "Posts")
                    UserStateView(value: 12, title: "Followers")
                    UserStateView(value: 24, title: "Following")
                }
                  
            }
            .padding(.horizontal)
            
            // name and bio
            VStack(alignment: .leading, spacing: 4)
            {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
//                    .background(.red)
            
            // action button
            
            Button(action: {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow user")
                }
            }, label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundStyle(user.isCurrentUser ? .black : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear,
                                    lineWidth: 1.0)
                    }
            })
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile, content: {
            EditProfileView(user: user)
        })
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[3])
}
