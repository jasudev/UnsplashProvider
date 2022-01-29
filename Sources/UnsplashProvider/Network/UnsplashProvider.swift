//
//  UnsplashProvider.swift
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
import Combine
import Alamofire

public typealias UPPhotosBlock = ([UPPhoto]?, Error?) -> Void
public typealias UPPhotoBlock = (UPPhoto?, Error?) -> Void
public typealias UPSearchPhotosBlock = (UPSearchResult<UPPhoto>?, Error?) -> Void
public typealias UPSearchUsersBlock = (UPSearchResult<UPUser>?, Error?) -> Void

public class UnsplashProvider {
    
    private var subscription = Set<AnyCancellable>()
    
    public init() {}
    
    /// Load multiple photos.
    ///
    /// - Parameters:
    ///   - router: UAPIRouter
    ///   - completed: ([UPPhoto]?, Error?) -> Void
    ///
    public func loadPhotos(router: UPAPIRouter, completed: @escaping UPPhotosBlock) {
        AF.request(router)
            .publishDecodable(type: [UPPhoto].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    completed(nil, error)
                }
            }, receiveValue: { receivedValue in
                if let values = receivedValue.value {
                    completed(values, nil)
                }
            })
            .store(in: &subscription)
    }

    /// Load a single photo.
    ///
    /// - Parameters:
    ///   - router: UAPIRouter
    ///   - completed: (UPPhoto?, Error?) -> Void
    ///
    public func loadPhoto(router: UPAPIRouter, completed: @escaping UPPhotoBlock) {
        AF.request(router)
            .publishDecodable(type: UPPhoto.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    completed(nil, error)
                }
            }, receiveValue: { receivedValue in
                if let value = receivedValue.value {
                    completed(value, nil)
                }
            })
            .store(in: &subscription)
    }
    
    /// Search for multiple photos.
    ///
    /// - Parameters:
    ///   - router: UAPIRouter
    ///   - completed: (UPSearchResult<UPPhoto>?, Error?) -> Void
    ///
    public func loadSearchPhotos(router: UPAPIRouter, completed: @escaping UPSearchPhotosBlock) {
        AF.request(router)
            .publishDecodable(type: UPSearchResult<UPPhoto>.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    completed(nil, error)
                }
            }, receiveValue: { receivedValue in
                if let value = receivedValue.value {
                    completed(value, nil)
                }
            })
            .store(in: &subscription)
    }
    
    /// Search for multiple users.
    ///
    /// - Parameters:
    ///   - router: UAPIRouter
    ///   - completed: (UPSearchResult<UPUser>?, Error?) -> Void
    ///
    public func loadSearchUsers(router: UPAPIRouter, completed: @escaping UPSearchUsersBlock) {
        AF.request(router)
            .publishDecodable(type: UPSearchResult<UPUser>.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    completed(nil, error)
                }
            }, receiveValue: { receivedValue in
                if let value = receivedValue.value {
                    completed(value, nil)
                }
            })
            .store(in: &subscription)
    }
}
