//
//  MAErrorAlerts.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 22/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit


struct MAAlert {
    
    static func show(on vc:UIViewController,message:String) {
        let alert = UIAlertController(title: "Oh no", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
