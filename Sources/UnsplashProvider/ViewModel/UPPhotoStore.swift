//
//  UPPhotoStore.swift
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

public class UPPhotoStore: UPStore {

    @Published public var photo: UPPhoto? = nil

    /// Retrieve a single photo.
    ///
    /// - Parameters:
    ///   - id: The photo’s ID. Required.
    ///
    public func fetchPhoto(id: String) {
        self.router = UPAPIRouter.photo(id: id)
        self.isLoading = true
        self.provider.loadPhoto(router: self.router) { value, error in
            if let photo = value {
                self.photo = photo
            }
            self.isLoading = false
        }
    }
}
