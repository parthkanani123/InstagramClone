//
//  UserStateView.swift
//  InstagramClone
//
//  Created by parth kanani on 15/04/24.
//

import SwiftUI

struct UserStateView: View 
{
    let value: Int
    let title: String
    
    var body: some View
    {
        VStack
        {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text(title)
                .font(.footnote)
        }
        .frame(width: 76)
    }
}

#Preview {
    UserStateView(value: 3, title: "Posts")
}
