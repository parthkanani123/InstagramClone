//
//  CustomButton.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct CustomButton: View 
{
    let title: String
    
    var body: some View
    {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemBlue))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.vertical)
    }
}

#Preview {
    CustomButton(title: "Login")
}
