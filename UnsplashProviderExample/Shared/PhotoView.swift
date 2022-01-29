//
//  PhotoView.swift
//  UnsplashProviderExample
//
//  Created by jasu on 2022/01/23.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import UnsplashProvider
import Zoomable

struct PhotoView: View {
    
    let photo: UPPhoto?
    let sizeType: UPPhotoSizeType
    
    var body: some View {
        if let photo = photo {
            ZoomableImageView(url: photo.urls.size(sizeType), min: 1.0, max: 3.0, showsIndicators: true) {
                CaptionView(user: photo.user)
            }
        }else {
            EmptyView()
        }
    }
}

struct CaptionView: View {
    
    @Environment(\.openURL) var openURL
    let user: UPUser?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if let user = user {
                    HStack(spacing: 0) {
                        Text("Photo by ")
                        Button {
                            openURL(user.linkUrls.html)
                        } label: {
                            Text("\(user.name ?? "")")
                                .underline()
                        }
                        Text(" on ")
                        Button {
                            if let url = URL(string: "https://unsplash.com") {
                                openURL(url)
                            }
                        } label: {
                            Text("Unsplash")
                                .underline()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.6))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.8))
                    .padding(.bottom, 10)
                    .clipped()
                }else {
                    EmptyView()
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: UPPhoto.getDummy(), sizeType: .regular)
    }
}
