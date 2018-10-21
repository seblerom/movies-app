//
//  MAMovieListCellCollectionViewCell.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieListCellCollectionViewCell: UICollectionViewCell {
    
    let posterImage : UIImageView = {
        let poster = UIImageView(frame: CGRect.zero)
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.backgroundColor = .gray
        poster.contentMode = .scaleAspectFill
        poster.image = #imageLiteral(resourceName: "venomPoster")
        return poster
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addImageConstraints()
    }
    
    private func addImageConstraints() {
        contentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
}
