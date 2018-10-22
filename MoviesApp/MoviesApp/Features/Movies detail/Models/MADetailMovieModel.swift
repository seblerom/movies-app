//
//  MADetailMovieModel.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation


struct MADetailMovieModel : Codable {
    let path : String
    let title : String
    let plot : String
    let configuration : MAApiImagesConfigurationModel
}
