//
//  MAApiImagesConfigurationModel.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation


struct MAApiImagesConfigurationModel : Codable {
    let images : MAImagesConfigurationModel
}

struct MAImagesConfigurationModel : Codable {
    
    let baseUrl : String
    let secureBaseUrl : String
    let backdropSizes : [String]
    let posterSizes : [String]
    
    enum CodingKeys : String,CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case posterSizes = "poster_sizes"
    }
    
}
