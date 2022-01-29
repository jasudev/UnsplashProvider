//
//  UPSearchPhotosStore.swift
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

public class UPSearchPhotosStore: UPStore {

    public var page: Int = 1
    @Published public var photos: [UPPhoto] = []

    /// Get a single page of photo results for a query.
    ///
    /// - Parameters:
    ///   - query: Search terms.
    ///   - page: Page number to retrieve. (Optional; default: 1)
    ///   - perPage: Number of items per page. (Optional; default: 30)
    ///   - orderBy: How to sort the photos. (Optional; default: relevant). Valid values are latest and relevant.
    ///   - collections: Collection ID(‘s) to narrow search. Optional. If multiple, comma-separated.
    ///   - contentFilter: Limit results by content safety. (Optional; default: low). Valid values are low and high.
    ///   - color: Filter results by color. Optional. Valid values are: black_and_white, black, white, yellow, orange, red, purple, magenta, green, teal, and blue.
    ///   - orientation: Filter by photo orientation. Optional. (Valid values: landscape, portrait, squarish)
    ///
    public func fetchSearchPhotos(query: String,
                     page: Int = 1,
                     perPage: Int = 30,
                     orderBy: UPSort = .relevant,
                     collections: String? = nil,
                     contentFilter: UPContentFilter? = nil,
                     color: UPColor? = nil,
                     orientation: UPOrientation? = nil) {
        
        if page <= 1 {
            self.page = 1; photos = []
        }else {
            self.page = page
        }
        
        self.router = UPAPIRouter.searchPhotos(query: query,
                                             page: self.page,
                                             perPage: perPage,
                                             orderBy: orderBy,
                                             collections: collections,
                                             contentFilter: contentFilter,
                                             color: color,
                                             orientation: orientation)
        
        self.isLoading = true
        self.provider.loadSearchPhotos(router: self.router) { value, error in
            if let result = value {
                self.photos += result.results
            }
            self.isLoading = false
        }
    }
}
    
