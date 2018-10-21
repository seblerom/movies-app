//
//  UICollectionViewCell + MoviesApp.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit


extension UICollectionViewCell {
    
    static internal var cellId: String {
        return String(describing: self.self)
    }
    
}
