//
//  CircularProfileImageView.swift
//  InstagramClone
//
//  Created by parth kanani on 28/04/24.
//

import SwiftUI
import Kingfisher

// Third - party library -> Kingfisher is light weight swift package used for downloading and caching images.

enum ProfileImageSize
{
    case xSmall // extra small
    case small
    case medium
    case large
    
    var dimension: CGFloat 
    {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View 
{
    let user: User
    let size: ProfileImageSize
    
    var body: some View
    {
        if let imageUrl = user.profileImageUrl
        {
            // This KFImage is from Kingfisher library and it takes URL and builds out an Image or render Image
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[4], size: .large)
}
