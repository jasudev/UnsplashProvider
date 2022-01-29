//
//  RowUserView.swift
//  UnsplashProviderExample
//
//  Created by jasu on 2022/01/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import UnsplashProvider

struct RowUserView: View {
    
    let user: UPUser?
    
    var body: some View {
        if let user = user {
            WebImage(url: user.profileUrls.large)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .listRowInsets(EdgeInsets())
                .clipShape(Rectangle())
                .padding(.vertical, 4)
        }else {
            EmptyView()
        }
    }
}

struct RowUserView_Previews: PreviewProvider {
    static var previews: some View {
        RowUserView(user: UPUser.getDummy())
    }
}
