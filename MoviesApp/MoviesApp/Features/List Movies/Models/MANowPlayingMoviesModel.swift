//
//  MANowPlayingMoviesModel.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

struct MANowPlayingMoviesModel : Codable {
    
    let page:Int
    let totalResults : Int
    let dates : MANowPlayingMoviesDateModel
    let totalPages : Int
    let results : [MANowPlayingMoviesResultModel]
    
    enum CodingKeys : String, CodingKey {
        case page,dates,results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct MANowPlayingMoviesResultModel : Codable {
    
    let voteCount : Int
    let id : Int
    let video : Bool
    let voteAverage : CGFloat
    let title : String
    let posterPath: String
    let originalLanguage : String
    let originalTitle : String
    let genreIds : [Int]
    let backDropPath : String?
    let adult : Bool
    let overview : String
    let releaseDate : String
    
    enum CodingKeys : String, CodingKey {
        
        case id,video,title,adult,overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backDropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
    
}

struct MANowPlayingMoviesDateModel : Codable {
    
    let maximum : String
    let minimum : String
    
}
