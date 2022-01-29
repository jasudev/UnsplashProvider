//
//  UPUserLinkURL.swift
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

public enum UPUserLinkType: String, Codable {
    case api = "self"
    case html
    case photos
    case likes
    case portfolio
    case following
    case followers
}

public struct UPUserLinkURL: Codable, Equatable {
    
    public var api: URL
    public var html: URL
    public var photos: URL
    public var likes: URL
    public var portfolio: URL
    public var following: URL
    public var followers: URL
    
    enum CodingKeys: String, CodingKey {
        case api = "self"
        case html
        case photos
        case likes
        case portfolio
        case following
        case followers
    }
    
    public func type(_ linkType: UPUserLinkType) -> URL {
        switch linkType {
        case .api:          return api
        case .html:         return html
        case .photos:       return photos
        case .likes:        return likes
        case .portfolio:    return portfolio
        case .following:    return following
        case .followers:    return followers
        }
    }
    
    public static func == (lhs: UPUserLinkURL, rhs: UPUserLinkURL) -> Bool {
        lhs.api == rhs.api &&
        lhs.html == rhs.html &&
        lhs.photos == rhs.photos &&
        lhs.likes == rhs.likes &&
        lhs.portfolio == rhs.portfolio &&
        lhs.following == rhs.following &&
        lhs.followers == rhs.followers
    }
}

