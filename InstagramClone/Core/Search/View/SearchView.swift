//
//  SearchView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct SearchView: View 
{
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                LazyVStack(spacing: 12)
                {
                    ForEach(viewModel.searchedUser) { user in
                        
                        NavigationLink(value: user) {
                            
                            HStack
                            {
                                CircularProfileImageView(user: user,
                                                         size: ProfileImageSize.xSmall)
                                
                                VStack(alignment: .leading)
                                {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    
                                    if let fullname = user.fullname {
                                        Text(fullname)
                                    }
                                }
                                .font(.footnote)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 8)
                .searchable(text: $viewModel.searchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .onAppear(perform: {
                    Task
                    {
                        try await viewModel.fetchAllUser()
                    }
                })
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
