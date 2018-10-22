//
//  MANowPlayingEndpoint.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

//Movies - Now playing endpoint
extension MAEndpoint {
    
    static func nowPlaying(_ page : Int = 1) -> MAEndpoint {
        return MAEndpoint(
            path: "/3/movie/now_playing",
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKeyValue(MAConstants.Plist.key)),
                URLQueryItem(name: "page", value: "\(page)")
                ]
        )
    }
}
