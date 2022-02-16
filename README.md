# **UnsplashProvider for SwiftUI**
It is a package that can use the Unsplash API. It was developed as a SwiftUI.

[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS-blue?style=flat-square)](https://developer.apple.com/macOS)
[![iOS](https://img.shields.io/badge/iOS-13.0-blue.svg)](https://developer.apple.com/iOS)
[![macOS](https://img.shields.io/badge/macOS-11.0-blue.svg)](https://developer.apple.com/macOS)
[![instagram](https://img.shields.io/badge/instagram-@dev.fabula-orange.svg?style=flat-square)](https://www.instagram.com/dev.fabula)
[![SPM](https://img.shields.io/badge/SPM-compatible-red?style=flat-square)](https://developer.apple.com/documentation/swift_packages/package/)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)  

## Screenshot
https://user-images.githubusercontent.com/1617304/153021842-cb46588f-69be-4df6-a290-e6d92349bb47.mp4

## Usage
```swift
import UnsplashProvider
```
```swift
// You must enter the application access key.
UPConfiguration.shared.accessKey = "" // <YOUR_ACCESS_KEY>
```

* How to use the built-in ObservableObject object
    ```swift
    @StateObject var photo = UPPhotoStore()
    @StateObject var photos = UPPhotosStore()
    @StateObject var randomPhotos = UPRandomPhotosStore()
    @StateObject var searchPhotos = UPSearchPhotosStore()
    @StateObject var searchUsers = UPSearchUsersStore()
    
    ...
    
    List(photos.photos) { photo in
        ...
    }
    List(randomPhotos.photos) { photo in
        ...
    }
    List(searchPhotos.photos) { photo in
        ...
    }
    List(searchUsers.users) { user in
        ...
    }
    
    ...
    
    // func fetchPhoto(id: String)
    photo.fetchPhoto(id: "F3OvjNcF5Xg") 
    
    // func fetchPhotos(page: Int = 1, perPage: Int = 30, orderBy: UPSort = .latest)
    photos.fetchPhotos(orderBy: .popular) 
    
    // func fetchPhotos(collections: String? = nil, topics: String? = nil, username: String? = nil, query: String? = nil, orientation: UPOrientation? = nil, contentFilter: UPContentFilter? = nil, count: Int = 1)
    randomPhotos.fetchPhotos(query: "cat", count: 30) 
    
    // func fetchSearchPhotos(query: String, page: Int = 1, perPage: Int = 30, orderBy: UPSort = .relevant, collections: String? = nil, contentFilter: UPContentFilter? = nil, color: UPColor? = nil, orientation: UPOrientation? = nil)
    searchPhotos.fetchSearchPhotos(query: "colorful", orientation: .squarish) 
    
    // func fetchSearchUsers(query: String, page: Int = 1, perPage: Int = 30)
    searchUsers.fetchSearchUsers(query: "lo") 
    
    ```

        
* How to use Router directly.
    ```swift
    let router = UPAPIRouter.randomPhotos(query: "colorful", orientation: .landscape)
    UnsplashProvider().loadPhotos(router: router) { photos, error in
        guard error == nil else { return }
        if let photos = photos, !photos.isEmpty {
            let photo = photos[0]
            self.currentPhoto = photo
        }
    }
    ```

## Swift Package Manager
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. Once you have your Swift package set up, adding UnsplashProvider as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/jasudev/UnsplashProvider.git", .branch("main"))
]
```

## Contact
instagram : [@dev.fabula](https://www.instagram.com/dev.fabula)  
email : [dev.fabula@gmail.com](mailto:dev.fabula@gmail.com)

## License
UnsplashProvider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
