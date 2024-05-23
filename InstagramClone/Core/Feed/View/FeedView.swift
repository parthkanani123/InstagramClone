//
//  FeedView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct FeedView: View
{
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                LazyVStack(spacing: 32)
                {
                    ForEach(viewModel.posts, id: \.self) { post in
                        
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Image("instagram_logo_black")
                        .resizable()
                        .frame(width: 100, height: 32)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            })
            .refreshable {
                Task
                {
                    try await viewModel.fetchPosts()
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
