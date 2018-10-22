//
//  MAMovieImage.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class MAMovieImage : UIImageView {
    
    func loadImage(_ size:String,_ path: String) {
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: path as NSString) {
            self.image = imageFromCache
            return
        }
        
        let networkClient = MANetworkClient()
        networkClient.execute(.image(size, path)) { (result) in
            
            switch result{
            case .failure(let error):
                print(error.reason)
            case .success(let response):
                guard let data = response as? Data,let imageFromServer = UIImage(data: data) else { return }
                self.image = imageFromServer
                imageCache.setObject(imageFromServer, forKey: path as NSString)
            }
        }
    }
    
}
