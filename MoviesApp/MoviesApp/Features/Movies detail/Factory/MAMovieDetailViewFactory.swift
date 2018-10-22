//
//  MAMovieDetailViewFactory.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit


class MAMovieDetailViewFactory {
    
    func makeDetailView(model:MADetailMovieModel) ->  MAMovieDetailView {
        let view = MAMovieDetailView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = model.title
        view.plotOverViewLabel.text = model.plot
        return view
    }
    
}
