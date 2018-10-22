//
//  MAMovieListCellCollectionViewCell.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieListCellCollectionViewCell: UICollectionViewCell {
    
    var resultModel: MANowPlayingMoviesResultModel?
    var configuration : MAApiImagesConfigurationModel?
    
    let posterImage : MAMovieImage = {
        let poster = MAMovieImage(frame: CGRect.zero)
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = #colorLiteral(red: 0.1868241429, green: 0.1963080466, blue: 0.2039772272, alpha: 0.5)
        poster.clipsToBounds = true
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

extension MAMovieListCellCollectionViewCell : MAConfigurable {
    
    func configure(_ resultModel: MANowPlayingMoviesResultModel, _ configuration: MAApiImagesConfigurationModel) {
        self.resultModel = resultModel
        self.configuration = configuration
        prepareForLoadImage()
    }
    
    private func prepareForLoadImage() {
        guard let path = resultModel?.posterPath else { return }
        posterImage.loadImage(imageSize(), path)
    }
    
    private func imageSize() -> String {

        let size = configuration?.images.posterSizes.filter({ $0 == MAConstants.PosterSize.w500.rawValue })
        
        return size?.first ?? MAConstants.PosterSize.original.rawValue
    }
    
}



