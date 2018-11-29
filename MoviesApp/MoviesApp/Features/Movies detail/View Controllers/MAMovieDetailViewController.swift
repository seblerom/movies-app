//
//  MAMovieDetailViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieDetailViewController: UIViewController {
    
    //Variables
    lazy var presenter = MAMovieDetailPresenter(delegate: self)
    
    init(model : MADetailMovieModel) {
        super.init(nibName: nil,bundle: nil)
        presenter.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Details"
        view.backgroundColor = .black
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setCustomStyle()
    }
    
}

//MARK: - MASetupable
extension MAMovieDetailViewController : MASetupable {
    
    func viewSetup() {
        presenter.prepareDetailView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setConstraints(for detailView:MAMovieDetailView) {
        
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
    }
    
}

//MARK: - MAMovieDetailPresenterDelegate
extension MAMovieDetailViewController : MAMovieDetailPresenterDelegate {
    
    func didCreateDetailView(_ view: MAMovieDetailView) {
        setConstraints(for: view)
        view.backDropImage.loadImage(presenter.imageSize(),presenter.path())
    }
}
