//
//  AddEmailView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct AddEmailView: View 
{
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            
            OnboardingHeaderView(title: "Add your email",
                                 description: "You'll use this email to sign in to your account")
    
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreateUsernameView()
                    .navigationBarBackButtonHidden()
            } label: {
                CustomButton(title: "Next")
            }
            
            Spacer()
        } // we don't wrap up this VStack into NavigationStack bcz we are using this AddEmailView into LoginView which have navigation stack
        .toolbar(content: { // we have hide default back button in LoginView and below we have created our custom back button
            ToolbarItem(placement: .topBarLeading) {
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
    AddEmailView()
}
