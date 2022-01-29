//
//  UPPhotoLinkURL.swift
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

public enum UPPhotoLinkType: String, Codable {
    case api = "self"
    case html
    case download
    case downloadLocation = "download_location"
}

public struct UPPhotoLinkURL: Codable, Equatable {
    
    public var api: URL
    public var html: URL
    public var download: URL
    public var downloadLocation: URL
    
    enum CodingKeys: String, CodingKey {
        case api = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
    
    public func type(_ linkType: UPPhotoLinkType) -> URL {
        switch linkType {
        case .api:              return api
        case .html:             return html
        case .download:         return download
        case .downloadLocation: return downloadLocation
        }
    }
    
    public static func == (lhs: UPPhotoLinkURL, rhs: UPPhotoLinkURL) -> Bool {
        lhs.api == rhs.api &&
        lhs.html == rhs.html &&
        lhs.download == rhs.download &&
        lhs.downloadLocation == rhs.downloadLocation
    }
}

