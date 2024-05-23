//
//  CreateUsernameView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct CreateUsernameView: View 
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            OnboardingHeaderView(title: "Create username",
                                 description: "Pick a username for your new account. You can always change it later.")
            
            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                CustomButton(title: "Next")
            }
            
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                
                // we have hide default back button in AddEmailView and below we have created our custom back button
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
    CreateUsernameView()
}
