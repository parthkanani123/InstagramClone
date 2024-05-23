//
//  CreatePasswordView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct CreatePasswordView: View 
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            OnboardingHeaderView(title: "Create a password",
                                 description: "Your password must be at least 6 characters in length.")
            
            SecureField("Password", text: $viewModel.password)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSignUpView()
                    .navigationBarBackButtonHidden()
            } label: {
                CustomButton(title: "Next")
            }
            
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                
                // we have hide default back button in UsernameView and below we have created our custom back button
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
    CreatePasswordView()
}
