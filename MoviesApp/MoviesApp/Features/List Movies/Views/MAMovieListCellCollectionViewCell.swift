//
//  MAMovieListCellCollectionViewCell.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

class MAMovieListCellCollectionViewCell: UICollectionViewCell {
    
    private var resultModel: MANowPlayingMoviesResultModel?
    private var configuration : MAApiImagesConfigurationModel?
    var poster : MAMovieImage!
    
//    let posterImage : UIImageView = {
//        let poster = UIImageView(frame: CGRect.zero)
//        poster.translatesAutoresizingMaskIntoConstraints = false
//        poster.contentMode = .scaleAspectFill
//        poster.backgroundColor = .white
//        poster.clipsToBounds = true
//        return poster
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupViews() {
//        addImageConstraints()
//    }
//
//    private func addImageConstraints() {
//        contentView.addSubview(posterImage)
//        NSLayoutConstraint.activate([
//            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
//            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            ])
//    }

}

extension MAMovieListCellCollectionViewCell : MAConfigurable {
    
    func configure(_ resultModel: MANowPlayingMoviesResultModel, _ configuration: MAApiImagesConfigurationModel) {
        self.resultModel = resultModel
        self.configuration = configuration

        
        guard let size = configuration.images.posterSizes.last, let path = resultModel.backDropPath else {
            self.backgroundColor = .white
            return
        }
        
        let imageFactory = MAMovieImageFactory()
        poster = imageFactory.makeMovieImageView(MAImageModel(size: size, path: path))

        contentView.addSubview(poster)

        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        self.layoutIfNeeded()
        poster.loadImage()
        
    }
    
//    func loadImage(_ size:String,_ path: String) {
//        let networkClient = MANetworkClient()
//        networkClient.loadImage(.image(size, path)) { (data, error) in
//            if let data = data {
//                self.posterImage.image = UIImage(data: data)
//            }else {
//                self.backgroundColor = .white
//            }
//        }
//    }
    
    
    
}

protocol MAConfigurable {
    func configure(_ resultModel: MANowPlayingMoviesResultModel,_ configuration:MAApiImagesConfigurationModel)
}

class MAMovieImage : UIImageView {
    
    let model : MAImageModel
    
    init(model : MAImageModel) {
        self.model = model
        super.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage() {

        let networkClient = MANetworkClient()
        networkClient.loadImage(.image(model.size, model.path)) { (data, error) in
            if let data = data {
                self.image = UIImage(data: data)
            }else {
                self.backgroundColor = .white
            }
        }
    }
    
}

struct MAImageModel {
    let size : String
    let path : String
}

class MAMovieImageFactory {
    
    func makeMovieImageView(_ imageModel:MAImageModel) -> MAMovieImage {
        let imageView = MAMovieImage(model: imageModel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
}
