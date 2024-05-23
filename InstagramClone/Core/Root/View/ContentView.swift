//
//  ContentView.swift
//  InstagramClone
//
//  Created by parth kanani on 15/04/24.
//

import SwiftUI

struct ContentView: View 
{
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View
    {
        Group
        {
            // we are presenting view based on userSession, if userSession is nil means user is not logged in
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
