//
//  MASearchEndpoint.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

//Search Endpoint
extension MAEndpoint {
    
    static func search(_ query:String,includeAdult:Bool = true) -> MAEndpoint {
        return MAEndpoint(
            path: "/3/search/movie",
            queryItems: [
                URLQueryItem(name: "api_key",value: apiKeyValue(MAConstants.Plist.key)),
                URLQueryItem(name: "query",value: query),
                URLQueryItem(name: "include_adult",value: "\(includeAdult)"),
                URLQueryItem(name: "language",value: "en-US")
                ]
        )
    }
}
