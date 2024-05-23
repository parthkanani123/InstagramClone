//
//  FeedCell.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI
import Kingfisher

struct FeedCell: View 
{
    let post: Post
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                // image + username
                
                NavigationLink(value: post.user) 
                {
                    HStack
                    {
                        if let user = post.user {
                            
                            CircularProfileImageView(user: user, size: .xSmall)
                            
                            Text(user.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 8)
                }
                
                // post image
                
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(Rectangle())
                
                
                // action buttons
                HStack(spacing: 16)
                {
                    Button(action: {
                        print("Like post")
                    }, label: {
                        Image(systemName: "heart")
                            .imageScale(.large)
                    })
                    
                    Button(action: {
                        print("Comment on post")
                    }, label: {
                        Image(systemName: "bubble.right")
                            .imageScale(.large)
                    })
                    
                    Button(action: {
                        print("Share post")
                    }, label: {
                        Image(systemName: "paperplane")
                            .imageScale(.large)
                    })
                    
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.top, 4)
                .foregroundStyle(.black)
                
                // likes label
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 1)
                
                // caption label
                HStack
                {
                    // if we not add plus then to apply modifier to first text component is tricky and also without plus if second component is too large then it goes into new line with messy spacing. but by adding plus they combine in same spacing.
                    Text("\(post.user?.username ?? "") ").fontWeight(.semibold) +
                    Text(post.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.top, 1)
                
                // Time stamp label
                Text("6h ago")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 1)
            }
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[0])
}
