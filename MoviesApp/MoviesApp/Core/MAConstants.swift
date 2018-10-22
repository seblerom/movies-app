//
//  MAConstants.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

enum MAConstants {
    
    enum Plist {
        static let key = "THE_MOVIE_DB_API_KEY"
        static let fileName = "keys"
        static let fileExtension = "plist"
    }
    
    enum Urls {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let hostImage = "image.tmdb.org"
    }
    
    enum UserDefaults {
        static let dateKey = "DATE_KEY"
    }
    
    enum Configuration {
        static let file = "CONFIGURATION_FILE"
    }
    
}
