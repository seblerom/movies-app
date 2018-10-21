//
//  MAMovieDetailViewFactory.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation


class MAMovieDetailViewFactory {
    
    func makeDetailView(image:UIImage,title:String,plot:String) ->  UIView {
        let view = MAMovieDetailView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backDropImage.image = image
        view.titleLabel.text = title
        view.plotOverViewLabel.text = plot
        return view
    }
    
}
