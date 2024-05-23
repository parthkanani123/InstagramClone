//
//  PostGridView.swift
//  InstagramClone
//
//  Created by parth kanani on 17/04/24.
//

import SwiftUI
import Kingfisher

struct PostGridView: View 
{
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User)
    {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    // we are subtracting 1 pixel here for gap between images
    private let imageDimnesions: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View
    {
        LazyVGrid(columns: gridItems, spacing: 1, content: {
            
            ForEach(viewModel.posts) { post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimnesions, height: imageDimnesions)
                    .clipped() // if the height and width goes out of imageDimnesions we clipped it or we can say we have crop image.
            }
        })
        .onAppear(perform: {
            Task
            {
                try await viewModel.fetchUserPosts()
            }
        })
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
