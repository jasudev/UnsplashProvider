//
//  UPUser.swift
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

import Foundation

public struct UPUser: Codable, Identifiable, Equatable {

    public var id: String
    public var username: String
    public var name: String?
    public var firstName: String?
    public var lastName: String?
    public var twitterUsername: String?
    public var portfolioURL: URL?
    public var bio: String?
    public var location: String?
    public let linkUrls: UPUserLinkURL
    public let profileUrls: UPProfileSizeURL
    public var instagramUsername: String?
    public var totalCollectionCount: Int
    public var totalLikeCount: Int
    public var totalPhotoCount: Int
    public let social: UPSocialURL

    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio
        case location
        case linkUrls = "links"
        case profileUrls = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollectionCount = "total_collections"
        case totalLikeCount = "total_likes"
        case totalPhotoCount = "total_photos"
        case social
    }
    
    public init(from decoder: Decoder) throws {
        let containerValue = try decoder.container(keyedBy: CodingKeys.self)
        id = try containerValue.decode(String.self, forKey: .id)
        username = try containerValue.decode(String.self, forKey: .username)
        name = try? containerValue.decode(String.self, forKey: .name)
        firstName = try? containerValue.decode(String.self, forKey: .firstName)
        lastName = try? containerValue.decode(String.self, forKey: .lastName)
        twitterUsername = try? containerValue.decode(String.self, forKey: .twitterUsername)
        portfolioURL = try? containerValue.decode(URL.self, forKey: .portfolioURL)
        bio = try? containerValue.decode(String.self, forKey: .bio)
        location = try? containerValue.decode(String.self, forKey: .location)
        linkUrls = try containerValue.decode(UPUserLinkURL.self, forKey: .linkUrls)
        profileUrls = try containerValue.decode(UPProfileSizeURL.self, forKey: .profileUrls)
        instagramUsername = try? containerValue.decode(String.self, forKey: .instagramUsername)
        totalCollectionCount = try containerValue.decode(Int.self, forKey: .totalCollectionCount)
        totalLikeCount = try containerValue.decode(Int.self, forKey: .totalLikeCount)
        totalPhotoCount = try containerValue.decode(Int.self, forKey: .totalPhotoCount)
        social = try containerValue.decode(UPSocialURL.self, forKey: .social)
    }
    
    public func encode(to encoder: Encoder) throws {
        var containerValue = encoder.container(keyedBy: CodingKeys.self)
        try containerValue.encode(id, forKey: .id)
        try containerValue.encode(username, forKey: .username)
        try? containerValue.encode(name, forKey: .name)
        try? containerValue.encode(firstName, forKey: .firstName)
        try? containerValue.encode(lastName, forKey: .lastName)
        try? containerValue.encode(twitterUsername, forKey: .twitterUsername)
        try? containerValue.encode(portfolioURL, forKey: .portfolioURL)
        try? containerValue.encode(bio, forKey: .bio)
        try? containerValue.encode(location, forKey: .location)
        try containerValue.encode(linkUrls, forKey: .linkUrls)
        try containerValue.encode(profileUrls, forKey: .profileUrls)
        try? containerValue.encode(instagramUsername, forKey: .instagramUsername)
        try containerValue.encode(totalCollectionCount, forKey: .totalCollectionCount)
        try containerValue.encode(totalLikeCount, forKey: .totalLikeCount)
        try containerValue.encode(totalPhotoCount, forKey: .totalPhotoCount)
        try containerValue.encode(social, forKey: .social)
    }
    
    public static func == (lhs: UPUser, rhs: UPUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func getDummy() -> UPUser? {
        let photo: UPUser? = Bundle.decodeJSONFile("user")
        return photo
    }
}
