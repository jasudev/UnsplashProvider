//
//  ContentView.swift
//  UnsplashProviderExample
//
//  Created by jasu on 2022/01/21.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import UnsplashProvider

struct ContentView: View {
    
    private let provider = UnsplashProvider()
    @State private var currentPhoto: UPPhoto? = nil
    
    @StateObject var photo = UPPhotoStore()
    @StateObject var photos = UPPhotosStore()
    @StateObject var randomPhotos = UPRandomPhotosStore()
    @StateObject var searchPhotos = UPSearchPhotosStore()
    @StateObject var searchUsers = UPSearchUsersStore()
    
    init() {
        UPConfiguration.shared.accessKey = "" // <YOUR_ACCESS_KEY>
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(spacing: 0) {
                    PhotoView(photo: currentPhoto, sizeType: .regular)
                        .frame(height: proxy.size.width)
                    HStack(spacing: 10) {
                        List(photos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                        List(randomPhotos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                        List(searchPhotos.photos) { photo in
                            RowPhotoView(photo: photo)
                        }
                        List(searchUsers.users) { user in
                            RowUserView(user: user)
                        }
                    }
                    .padding(6)
                    .listStyle(PlainListStyle())
                }
            }
#if os(iOS)
            .navigationBarHidden(true)
#else
            .frame(minWidth: 500)
#endif
        }
        .onAppear {
            fetchRandomPhoto()
//            photo.fetchPhoto(id: "F3OvjNcF5Xg")
            photos.fetchPhotos(orderBy: .popular)
            randomPhotos.fetchPhotos(query: "cat", count: 30)
            searchPhotos.fetchSearchPhotos(query: "colorful", orientation: .squarish)
            searchUsers.fetchSearchUsers(query: "lo")
        }
    }
    
    private func fetchRandomPhoto() {
        let router = UPAPIRouter.randomPhotos(query: "colorful", orientation: .squarish)
        provider.loadPhotos(router: router) { photos, error in
            guard error == nil else { return }
            if let photos = photos, !photos.isEmpty {
                let photo = photos[0]
                self.currentPhoto = photo
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
