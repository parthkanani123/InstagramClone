//
//  InstagramCloneApp.swift
//  InstagramClone
//
//  Created by parth kanani on 15/04/24.
//

// some notes regarding firebase setup
/*
 
 we have setup three things on firebase
 1) Authentication :- this is for just creating a user
 
 2) Firestore Database :- database is going to help us to store all of that user information like their username, fullname, email all of that stuff. Authentication component is like just to create a user account. so just we create a user account does not mean that we have stored information about that user in our database.
 
 3) Storage :- this is going for storing images. so we think that we just setup a database, isn't that where our images go and the answer to that is no. because image files are so large, you actually don't want to upload images directly to your database, you want to upload them to a separate storage bucket, where all of the images files exist and what we are going to put in the database is what's known as imageURL. it just serves as a pointer to the location of that image inside of our storage bucket.
 */

import SwiftUI

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate 
{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}



@main
struct InstagramCloneApp: App 
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene
    {
        WindowGroup 
        {
            ContentView()
        }
    }
}
