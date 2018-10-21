//
//  MAMovieDetailViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieDetailViewController: UIViewController {
    
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
        let detailView = factory.makeDetailView(image: #imageLiteral(resourceName: "backDropTestImage"), title: "Avengers: Era de ultron", plot: "Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code. Moving our view code from a UIViewController subclass to a UIView subclass might not seem like that big of a deal. But this approach starts to become a lot more powerful once we start combining it with other patterns that let us improve the encapsulation of our code.")
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

