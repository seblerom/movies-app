//
//  MAConfigurable.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

protocol MAConfigurable {
    func configure(_ resultModel: MANowPlayingMoviesResultModel,
                   _ configuration:MAApiImagesConfigurationModel)
}


protocol MASetupable {
    func viewSetup()
}
