//
//  LoginView.swift
//  InstagramClone
//
//  Created by parth kanani on 16/04/24.
//

import SwiftUI

struct LoginView: View 
{
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View
    {
        NavigationStack // because we have to navigate to the Signup flow
        {
            VStack
            {
                Spacer()
                
                // logo image
                Image("instagram_logo_black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                // text fields
                VStack
                {
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.never) // in some TextField we are using Autocapitalization, that's why we have not wrap it up into TextFieldModifier
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }
                
                Button(action: {
                    print("Show forgot password")
                }, label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                        .padding(.top)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 28)
                
                
                Button(action: {
                    Task {
                        try await viewModel.signIn()
                    }
                }, label: {
                    CustomButton(title: "Login")
                })
                
                HStack
                {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                        
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                        
                }
                .foregroundStyle(.gray)
                
                HStack
                {
                    Image("fb_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Continue with facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                .padding(.top, 8)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3)
                    {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundStyle(.blue)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
