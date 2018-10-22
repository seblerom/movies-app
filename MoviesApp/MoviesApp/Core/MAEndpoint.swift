//
//  MAEndpoint.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

struct MAEndpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension MAEndpoint {
    
    static func apiKeyValue(_ keyName:String) -> String {
        
        guard let filePath = Bundle.main.path(forResource: MAConstants.Plist.fileName, ofType: MAConstants.Plist.fileExtension) else { return ""}
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        let value = plist?.object(forKey: keyName) as! String
        
        return value
    }

}

extension MAEndpoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = MAConstants.Urls.scheme
        components.host = MAConstants.Urls.host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

//Configuration endpoint
extension MAEndpoint {
    
    static func configuration() -> MAEndpoint {
        return MAEndpoint(
            path: "/3/configuration",
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKeyValue(MAConstants.Plist.key)),
                ]
        )
    }
}

//Movies - Now playing endpoint
extension MAEndpoint {
    
    static func nowPlaying(_ page : Int = 1) -> MAEndpoint {
        return MAEndpoint(
            path: "/3/movie/now_playing",
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKeyValue(MAConstants.Plist.key)),
                URLQueryItem(name: "page", value: "\(page)"),
//                URLQueryItem(name: "language", value: "en-US")
                ]
        )
    }
}


//Poster image - endpoint
extension MAEndpoint {
    
    static func image(_ size : String, _ path : String) -> MAEndpoint {
        return MAEndpoint(
            path: "/t/p/\(size)\(path)", queryItems: []
        )
    }
}

extension MAEndpoint {
    
    var imageUrl: URL? {
        var components = URLComponents()
        components.scheme = MAConstants.Urls.scheme
        components.host = MAConstants.Urls.hostImage
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

