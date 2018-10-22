//
//  MAMovieDetailViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieDetailViewController: UIViewController {
    
    let model : MADetailMovieModel
    
    init(model : MADetailMovieModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Details"
        view.backgroundColor = .black
        setViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setViewConstraints() {
        
        let factory = MAMovieDetailViewFactory()
        let detailView = factory.makeDetailView(model: model) 

        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
                detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                detailView.widthAnchor.constraint(equalTo: view.widthAnchor),
                ])
            let detailViewBottomConstraint = detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            detailViewBottomConstraint.priority = UILayoutPriority(rawValue: 250)
            detailViewBottomConstraint.isActive = true
        
        detailView.backDropImage.loadImage(imageSize(), model.path)
    }
    
    private func imageSize() -> String {
        
        let size = model.configuration.images.backdropSizes.filter({ $0 == MAConstants.BackdropSize.w1280.rawValue })
        
        return size.first ?? MAConstants.BackdropSize.original.rawValue
    }
    
    
}

