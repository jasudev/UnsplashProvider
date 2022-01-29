//
//  UPRandomPhotosStore.swift
//  UnsplashProvider
//
//  Created by jasu on 2022/01/22.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

public class UPRandomPhotosStore: UPStore {

    @Published public var photos: [UPPhoto] = []

    /// Retrieve a single random photo, given optional filters.
    ///
    /// - Parameters:
    ///   - collections: Public collection ID(‘s) to filter selection. If multiple, comma-separated
    ///   - topics: Public topic ID(‘s) to filter selection. If multiple, comma-separated
    ///   - username: Limit selection to a single user.
    ///   - query: Limit selection to photos matching a search term.
    ///   - orientation: Filter by photo orientation. (Valid values: landscape, portrait, squarish)
    ///   - contentFilter: Limit results by content safety. Default: low. Valid values are low and high.
    ///   - count: The number of photos to return. (Default: 1; max: 30)
    ///
    public func fetchPhotos(collections: String? = nil,
                     topics: String? = nil,
                     username: String? = nil,
                     query: String? = nil,
                     orientation: UPOrientation? = nil,
                     contentFilter: UPContentFilter? = nil,
                     count: Int = 1) {
        
        self.router = UPAPIRouter.randomPhotos(collections: collections,
                                             topics: topics,
                                             username: username,
                                             query: query,
                                             orientation: orientation,
                                             contentFilter: contentFilter,
                                             count: count)
        self.isLoading = true
        self.provider.loadPhotos(router: self.router) { value, error in
            if let photos = value {
                self.photos = photos
            }
            self.isLoading = false
        }
    }
}
