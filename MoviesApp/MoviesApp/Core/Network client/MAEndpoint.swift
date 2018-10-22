//
//  MAEndpoint.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

class MAEndpoint {
    let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    init(path:String,queryItems:[URLQueryItem]) {
        var components = URLComponents()
        components.scheme = MAConstants.Urls.scheme
        components.host = MAConstants.Urls.host
        components.path = path
        components.queryItems = queryItems
        self.url = components.url
    }
}

extension MAEndpoint {
    
    static func apiKeyValue(_ keyName:String) -> String {
        
        guard let filePath = Bundle.main.path(forResource: MAConstants.Plist.fileName, ofType: MAConstants.Plist.fileExtension) else { return ""}
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        let value = plist?.object(forKey: keyName) as! String
        
        return value
    }

}



//Poster image - endpoint
extension MAEndpoint {
    
    static func image(_ size : String, _ path : String) -> MAEndpoint {
        return MAImageEndpoint(
            path: "/t/p/\(size)\(path)", queryItems: []
        )
    }
}

class MAImageEndpoint: MAEndpoint {
    override init(path:String, queryItems:[URLQueryItem]) {
        var components = URLComponents()
        components.scheme = MAConstants.Urls.scheme
        components.host = MAConstants.Urls.hostImage
        components.path = path
        components.queryItems = queryItems
        super.init(url: components.url)
    }
}
