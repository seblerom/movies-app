//
//  MAMoviesListService.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation
import Alamofire


class MAMoviesListService {
    
    
    func service()  {
        
        let url = URL(string: "https://api.themoviedb.org/3/configuration?api_key=f3a9db1cdd8e8406b06d44d0228f124a")!
        
        Alamofire.request(url).responseJSON { (response) in
            
    
            if response.error != nil {
                print(response.error?.localizedDescription)
            }
            
            guard let data = response.data else {
                print("No hay data, tirar error")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let ddddd = try? jsonDecoder.decode(MAApiImagesConfigurationModel.self, from: data)
            print(ddddd)
            
            
        }
        
    }
    
    
}
