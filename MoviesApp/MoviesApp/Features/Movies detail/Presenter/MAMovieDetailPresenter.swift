//
//  MAMovieDetailPresenter.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 29/11/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

protocol MAMovieDetailPresenterDelegate : class {
    func didCreateDetailView(_ view:MAMovieDetailView)
}

class MAMovieDetailPresenter {
    
    weak var delegate : MAMovieDetailPresenterDelegate?
    var model : MADetailMovieModel?
    
    init(delegate : MAMovieDetailPresenterDelegate) {
        self.delegate = delegate
    }
    
    func prepareDetailView() {
        if let model = self.model {
            let factory = MAMovieDetailViewFactory()
            let detailView = factory.makeDetailView(model: model)
            self.delegate?.didCreateDetailView(detailView)
        }
    }
    
    func path() -> String {
        var imagePath = ""
        if let model = self.model,
            let path = model.path {
            imagePath = path
        }
        return imagePath
    }
    
    func imageSize() -> String {
        guard let model = self.model else {
            return MAConstants.BackdropSize.original.rawValue
        }
        
        let size = model.configuration.images.backdropSizes.filter({ $0 == MAConstants.BackdropSize.w1280.rawValue })
        return size.first ?? MAConstants.BackdropSize.original.rawValue
    }
    
}
