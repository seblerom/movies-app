//
//  MAConfigurationEnpoint.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

//Configuration endpoint
extension MAEndpoint {
    
    static func configuration() -> MAEndpoint {
        return MAEndpoint(
            path: "/3/configuration",
            queryItems: [
                URLQueryItem(name: "api_key",value: apiKeyValue(MAConstants.Plist.key))
                ]
        )
    }
}
