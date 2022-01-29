//
//  UPSocialURL.swift
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

public enum UPSocialType: String, Codable {
    case instagramUsername = "instagram_username"
    case portfolio = "portfolio_url"
    case twitterUsername = "twitter_username"
    case paypalEmail = "paypal_email"
}

public struct UPSocialURL: Codable, Equatable {
    
    public var instagramUsername: String?
    public var portfolio: String?
    public var twitterUsername: String?
    public var paypalEmail: String?
    
    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolio = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
    
    public func type(_ socialType: UPSocialType) -> String {
        switch socialType {
        case .instagramUsername:    return instagramUsername ?? ""
        case .portfolio:            return portfolio ?? ""
        case .twitterUsername:      return twitterUsername ?? ""
        case .paypalEmail:          return paypalEmail ?? ""
        }
    }
    
    public static func == (lhs: UPSocialURL, rhs: UPSocialURL) -> Bool {
        lhs.instagramUsername == rhs.instagramUsername &&
        lhs.portfolio == rhs.portfolio &&
        lhs.twitterUsername == rhs.twitterUsername &&
        lhs.paypalEmail == rhs.paypalEmail
    }
}
