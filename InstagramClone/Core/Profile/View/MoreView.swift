//
//  MoreView.swift
//  InstagramClone
//
//  Created by parth kanani on 23/05/24.
//

import SwiftUI

struct MoreView: View 
{
    var body: some View 
    {
        VStack(spacing: 12)
        {
            Spacer()
            
            ComponentView(logo: "gear",
                          description: "Setting and privacy")
            
            ComponentView(logo: "arrow.counterclockwise.square",
                          description: "Archive")
            
            ComponentView(logo: "square.and.arrow.down",
                          description: "Saved")
            
            ComponentView(logo: "qrcode.viewfinder", 
                          description: "QR code")
            
            ComponentView(logo: "creditcard", 
                          description: "Orders and payments")
            
            ComponentView(logo: "person.2",
                          description: "Supervision")
            
            ComponentView(logo: "star",
                          description: "Favorites")
            
            Button(action: {
                AuthService.shared.signout()
            }, label: {
                ComponentView(logo: "rectangle.portrait.and.arrow.right",
                              description: "Sign out")
            })
            
            Spacer()
        }
    }
}

#Preview {
    MoreView()
}

struct ComponentView: View 
{
    var logo: String
    var description: String
    
    var body: some View
    {
        HStack(spacing: 12)
        {
            Image(systemName: logo)
            
            Text(description)
                .fontWeight(.regular)
            
            Spacer()
        }
        .font(.title3)
        .padding(.leading)
    }
}
