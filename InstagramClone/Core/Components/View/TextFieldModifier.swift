//
//  IGTextFieldModifier.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier
{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 24)
    }
}
