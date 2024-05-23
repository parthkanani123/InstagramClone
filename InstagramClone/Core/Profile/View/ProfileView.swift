//
//  ProfileView.swift
//  InstagramClone
//
//  Created by parth kanani on 15/04/24.
//

import SwiftUI

struct ProfileView: View 
{
    let user: User
    
    var body: some View
    {
        ScrollView
        {
            // header
            ProfileHeaderView(user: user)
            
            // post grid view
            
            PostGridView(user: user)
        } // here there is no navigationStack, so this navigationTitle is not display on the Preview, but we are accessing this ProfileView from SearchView which has navigationStack, so when we tap on user from SearchView, we see this navigationTitle because we are navigationStack hierarchy.
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[4])
}
