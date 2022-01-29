//
//  UPPhoto.swift
//  UnsplashProvider
//
//  Created by jasu on 2022/01/21.
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

import SwiftUI

public struct UPPhoto: Codable, Identifiable, Equatable {
    
    public var id: String
    public var createdDate: Date?
    public var updatedDate: Date?
    public var promotedDate: Date?
    public var width: Int
    public var height: Int
    public var hexColor: String
    public var description: String?
    public var urls: UPPhotoSizeURL
    public var links: UPPhotoLinkURL
    public var likeCount: Int
    public var user: UPUser
    public var viewCount: Int?
    public var downloadCount: Int?
    
    public var color: Color {
        return Color(hex: hexColor)
    }
    public var ratioHeight: CGFloat {
        return CGFloat(height) / CGFloat(width)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case promotedDate = "promoted_at"
        case width
        case height
        case hexColor = "color"
        case description
        case urls
        case links
        case likeCount = "likes"
        case user
        case viewCount = "views"
        case downloadCount = "downloads"
    }
    
    public init(from decoder: Decoder) throws {
        let containerValue = try decoder.container(keyedBy: CodingKeys.self)
        id = try containerValue.decode(String.self, forKey: .id)
        createdDate = try? containerValue.decode(Date.self, forKey: .createdDate)
        updatedDate = try? containerValue.decode(Date.self, forKey: .updatedDate)
        promotedDate = try? containerValue.decode(Date.self, forKey: .promotedDate)
        width  = try containerValue.decode(Int.self, forKey: .width)
        height  = try containerValue.decode(Int.self, forKey: .height)
        hexColor = try containerValue.decode(String.self, forKey: .hexColor)
        description = try? containerValue.decode(String.self, forKey: .description)
        urls = try containerValue.decode(UPPhotoSizeURL.self, forKey: .urls)
        links = try containerValue.decode(UPPhotoLinkURL.self, forKey: .links)
        likeCount  = try containerValue.decode(Int.self, forKey: .likeCount)
        user = try containerValue.decode(UPUser.self, forKey: .user)
        viewCount  = try? containerValue.decode(Int.self, forKey: .viewCount)
        downloadCount  = try? containerValue.decode(Int.self, forKey: .downloadCount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var containerValue = encoder.container(keyedBy: CodingKeys.self)
        try containerValue.encode(id, forKey: .id)
        try? containerValue.encode(createdDate, forKey: .createdDate)
        try? containerValue.encode(updatedDate, forKey: .updatedDate)
        try? containerValue.encode(promotedDate, forKey: .promotedDate)
        try containerValue.encode(width, forKey: .width)
        try containerValue.encode(height, forKey: .height)
        try containerValue.encode(hexColor, forKey: .hexColor)
        try? containerValue.encode(description, forKey: .description)
        try containerValue.encode(urls, forKey: .urls)
        try containerValue.encode(links, forKey: .links)
        try containerValue.encode(likeCount, forKey: .likeCount)
        try containerValue.encode(user, forKey: .user)
        try? containerValue.encode(viewCount, forKey: .viewCount)
        try? containerValue.encode(downloadCount, forKey: .downloadCount)
    }
    
    public static func == (lhs: UPPhoto, rhs: UPPhoto) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func getDummy() -> UPPhoto? {
        let photo: UPPhoto? = Bundle.decodeJSONFile("photo")
        return photo
    }
}
