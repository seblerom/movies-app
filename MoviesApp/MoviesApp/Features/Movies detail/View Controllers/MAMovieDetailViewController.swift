//
//  MAMovieDetailViewController.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieDetailViewController: UIViewController {
    
    let backDropAspectRatio : CGFloat = 16/9
    let scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: CGRect.zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    let backDropImage : UIImageView = {
        let backDrop = UIImageView(frame: CGRect.zero)
        backDrop.translatesAutoresizingMaskIntoConstraints = false
        backDrop.backgroundColor = .gray
        backDrop.contentMode = .scaleAspectFill
        backDrop.image = #imageLiteral(resourceName: "backDropTestImage")
        return backDrop
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.lineBreakMode = .byWordWrapping
        label.text = "Avengers infinity wars Avengers infinity wars Avengers infinity wars Avengers infinity wars Avengers infinity wars "
        return label
    }()
    
    let plotOverViewLabel : UILabel = {
        let plot = UILabel(frame: CGRect.zero)
        plot.translatesAutoresizingMaskIntoConstraints = false
        plot.numberOfLines = 0
        plot.textColor = .white
        plot.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        plot.lineBreakMode = .byWordWrapping
        plot.textAlignment = .justified
        plot.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        return plot
    }()
    
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
        view.addSubview(scrollView)
        scrollView.addSubview(backDropImage)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(plotOverViewLabel)
        setScrollViewConstraints()
        setImageConstraints()
        setTitleConstraints()
        setPlotOverviewConstraints()
    }
    
    private func setScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        let scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        scrollViewBottomConstraint.priority = UILayoutPriority(rawValue: 250)
        scrollViewBottomConstraint.isActive = true
    }
    
    private func setImageConstraints() {

        NSLayoutConstraint.activate([
            backDropImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backDropImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backDropImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backDropImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            backDropImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor,constant:-16),
            backDropImage.heightAnchor.constraint(equalToConstant: view.bounds.width / backDropAspectRatio)
            ])
    }
    
    private func setTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant:16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant:-16),
            titleLabel.bottomAnchor.constraint(equalTo: plotOverViewLabel.topAnchor,constant:-16)
            ])
    }
    
    private func setPlotOverviewConstraints() {
        NSLayoutConstraint.activate([
            plotOverViewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant:16),
            plotOverViewLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant:-16),
            plotOverViewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant:-8)
            ])
    }
    
    
}
