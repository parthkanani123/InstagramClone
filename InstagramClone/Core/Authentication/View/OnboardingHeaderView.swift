//
//  OnboardingHeaderView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct OnboardingHeaderView: View 
{
    let title: String
    let description: String
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(description)
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center) // in iPhone 8 or in smaller screen phone this text might go to two lines, so we have to handle it.
                .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingHeaderView(title: "Add your email",
                         description: "You'll use this email to sign in to your account")
}
