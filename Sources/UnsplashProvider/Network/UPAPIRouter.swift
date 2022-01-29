//
//  UPAPIRouter.swift
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
import Alamofire

public enum UPSort: String {
    case latest
    case oldest
    case popular
    case relevant
}

public enum UPOrientation: String {
    case landscape
    case portrait
    case squarish
}

public enum UPContentFilter: String {
    case low
    case high
}

public enum UPColor: String {
    case black_and_white
    case black
    case white
    case yellow
    case orange
    case red
    case purple
    case magenta
    case green
    case teal
    case blue
}

public enum UPAPIRouter: URLRequestConvertible {
    case photos(page: Int = 1,
                perPage: Int = 30,
                orderBy: UPSort = .latest)
    case photo(id: String)
    case randomPhotos(collections: String? = nil,
                      topics: String? = nil,
                      username: String? = nil,
                      query: String? = nil,
                      orientation: UPOrientation? = nil,
                      contentFilter: UPContentFilter? = nil,
                      count: Int = 1)
    case searchPhotos(query: String,
                      page: Int = 1,
                      perPage: Int = 30,
                      orderBy: UPSort = .relevant,
                      collections: String? = nil,
                      contentFilter: UPContentFilter? = nil,
                      color: UPColor? = nil,
                      orientation: UPOrientation? = nil)
    case searchUsers(query: String,
                     page: Int = 1,
                     perPage: Int = 30)
    
    
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var endPoint: String {
        switch self {
        case .photos: return "/photos"
        case .photo(let id): return "/photos/" + id
        case .randomPhotos: return "/photos/random"
        case .searchPhotos: return "/search/photos"
        case .searchUsers: return "/search/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .photos, .photo, .randomPhotos, .searchUsers, .searchPhotos: return .get
        }
    }
    
    var parameters: Parameters? {
        var params = Parameters()
        switch self {
        case let .photos(page, perPage, orderBy):
            params["page"]  = page
            params["per_page"] = perPage
            params["order_by"] = orderBy.rawValue
        case .photo: return nil
        case let .randomPhotos(collections, topics, username, query, orientation, contentFilter, count):
            if let collections = collections { params["collections"] = collections }
            if let topics = topics { params["topics"] = topics }
            if let username = username { params["username"] = username }
            if let query = query { params["query"] = query }
            if let orientation = orientation { params["orientation"] = orientation.rawValue }
            if let contentFilter = contentFilter { params["content_filter"] = contentFilter.rawValue }
            params["count"] = count
        case let .searchPhotos(query, page, perPage, orderBy, collections, contentFilter, color, orientation):
            params["query"] = query
            params["page"] = page
            params["per_page"] = perPage
            params["order_by"] = orderBy.rawValue
            if let collections = collections { params["collections"] = collections }
            if let contentFilter = contentFilter { params["content_filter"] = contentFilter.rawValue }
            if let color = color { params["color"] = color.rawValue }
            if let orientation = orientation { params["orientation"] = orientation.rawValue }
        case let .searchUsers(query, page, perPage):
            params["query"] = query
            params["page"] = page
            params["per_page"] = perPage
        }
        return params
    }
    
    public func asURLRequest() throws -> URLRequest {
        guard !UPConfiguration.shared.accessKey.isEmpty else {
            fatalError("You must enter the application access key.")
        }
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        request.method = method
        request.setValue("Client-ID \(UPConfiguration.shared.accessKey)", forHTTPHeaderField: "Authorization")
        switch self {
        case .photos, .photo, .randomPhotos, .searchPhotos, .searchUsers:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        return request
    }
}

extension UPAPIRouter: CustomStringConvertible {
    public var description: String {
        let url = baseURL.appendingPathComponent(endPoint)
        var value: String = ""
        switch self {
        case let .photos(page, perPage, orderBy):
            value = "UPPRouter.photos(page: \(page), perPage: \(perPage), orderBy: \(orderBy.rawValue))"
        case let .photo(id):
            value = "UPPRouter.photos(id: \(id))"
        case let .randomPhotos(collections, topics, username, query, orientation, contentFilter, count):
            value = "UPPRouter.randomPhotos(collections: \(collections ?? "nil"), topics: \(topics ?? "nil"), username: \(username ?? "nil"), query: \(query ?? "nil"), orientation: \(orientation?.rawValue ?? "nil"), contentFilter: \(contentFilter?.rawValue ?? "nil"), count: \(count))"
            
        case let .searchPhotos(query, page, perPage, orderBy, collections, contentFilter, color, orientation):
            value = "UPPRouter.searchPhotos(query: \(query), page: \(page), perPage: \(perPage), orderBy: \(orderBy.rawValue), collections: \(collections ?? ""), contentFilter: \(contentFilter?.rawValue ?? "nil"), color: \(color?.rawValue ?? "nli"), orientation: \(orientation?.rawValue ?? "nil"))"
        case let .searchUsers(query, page, perPage):
            value = "UPPRouter.searchUsers(query: \(query), page: \(page), perPage: \(perPage))"
        }
        return "Path: \(url), \(value)"
    }
}
