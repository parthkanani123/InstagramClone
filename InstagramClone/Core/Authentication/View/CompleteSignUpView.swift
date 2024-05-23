//
//  CompleteSignUpView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct CompleteSignUpView: View 
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            Spacer()
            
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal, 24)
            
            Text("Click below to complete registration and start using instagram")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button(action: {
                Task {
                    try await viewModel.createUser()
                }
            }, label: {
                CustomButton(title: "Complete Sign Up")
            })
            
            Spacer()
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                
                // we have hide default back button in CreatePasswordView and below we have created our custom back button
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        })
    }
}

#Preview {
    CompleteSignUpView()
}
