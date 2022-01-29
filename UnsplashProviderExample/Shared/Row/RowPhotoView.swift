//
//  RowPhotoView.swift
//  UnsplashProviderExample
//
//  Created by jasu on 2022/01/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import UnsplashProvider

struct RowPhotoView: View {
    
    let photo: UPPhoto?
    
    var body: some View {
        if let photo = photo {
            ZStack {
                WebImage(url: photo.urls.size(.regular))
                    .resizable()
                    .placeholder {
                        Rectangle()
                            .fill(photo.color)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
                    .clipShape(Rectangle())
                    .padding(.vertical, 4)
                    .background(
                        NavigationLink(destination:
                                        Rectangle()
                                        .fill(photo.color)
                                        .edgesIgnoringSafeArea(.all)
                                        .overlay(
                                            PhotoView(photo: photo, sizeType: .full)
                                        )
                                       
                        ) {
                            EmptyView()
                        }
                    )
            }
            .listRowInsets(EdgeInsets())
        }else {
            EmptyView()
        }
    }
}

struct RowPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RowPhotoView(photo: UPPhoto.getDummy())
    }
}
