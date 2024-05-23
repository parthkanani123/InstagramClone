//
//  CurrentUserProfileView.swift
//  InstagramClone
//
//  Created by parth kanani on 17/04/24.
//

import SwiftUI

// we are going to access profileView from 2 side, one is from MainTabView and another is from SearchView. now SearchView contains navigationStack and our ProfileView also contain navigationStack, so when we click on user from SearchView, it's can't navigate us to ProfileView, because ProfileView also have navigationStack, which swift doesn't allowed(navigationStack hierarchy). so for our MainTabView we have create seperate profileView that is CurrentUserProfileView. and for searchView we are using ProfileView without navigationStack.

struct CurrentUserProfileView: View
{
    let user: User
    @State var isShowingMoreView = false
    
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                // header
                ProfileHeaderView(user: user)
                
                // post grid view
                
                PostGridView(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingMoreView.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    })
                }
            })
            .sheet(isPresented: $isShowingMoreView, content: {
                MoreView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            })
            .refreshable {
                Task
                {
                    try await AuthService.shared.loadUserData()
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[4])
}
