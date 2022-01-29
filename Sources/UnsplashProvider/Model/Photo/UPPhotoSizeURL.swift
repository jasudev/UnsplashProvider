//
//  UPPhotoSizeURL.swift
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
#if os(iOS)
import UIKit
#else
import AppKit
#endif

public enum UPPhotoSizeType: String, Codable {
    case raw
    case full
    case regular
    case small
    case thumb
}

public struct UPPhotoSizeURL: Codable, Equatable {
    
    /// returns a base image URL with just the photo path and the ixid parameter for your API application. Use this to easily add additional image parameters to construct your own image URL.
    public var raw: URL
    
    /// returns the photo in jpg format with its maximum dimensions. For performance purposes, we don’t recommend using this as the photos will load slowly for your users.
    public var full: URL
    
    /// returns the photo in jpg format with a width of 1080 pixels.
    public var regular: URL
    
    /// returns the photo in jpg format with a width of 400 pixels.
    public var small: URL
    
    /// returns the photo in jpg format with a width of 200 pixels.
    public var thumb: URL
    
    public func size(_ sizeType: UPPhotoSizeType) -> URL {
        switch sizeType {
        case .raw:      return raw
        case .full:     return full
        case .regular:  return regular
        case .small:    return small
        case .thumb:    return thumb
        }
    }
    
    public func size(_ point: Int) -> URL {
        let path = self.raw.absoluteString + "&fm=jpg&&q=85&crop=entropy&w=\(point)&dpr=\(getScale())"
        return URL(string: path)!
    }
    
    public static func == (lhs: UPPhotoSizeURL, rhs: UPPhotoSizeURL) -> Bool {
        lhs.raw == rhs.raw &&
        lhs.full == rhs.full &&
        lhs.regular == rhs.regular &&
        lhs.small == rhs.small &&
        lhs.thumb == rhs.thumb
    }
    
    private func getScale() -> Int {
        #if os(iOS)
            return Int(UIScreen.main.scale)
        #else
        return Int(NSScreen.main?.backingScaleFactor ?? 1)
        #endif
    }
}

