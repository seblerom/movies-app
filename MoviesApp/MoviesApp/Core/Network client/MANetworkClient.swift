//
//  MANetworkClient.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation


class MANetworkClient {
    
    typealias WebServiceResponse = (_ model:Data?,_ error:Error?) -> Void
    
    func execute(_ endpoint:MAEndpoint, completionHandler: @escaping WebServiceResponse) {
        
        guard let url = endpoint.url else {
            completionHandler(nil,nil)
            return
        }
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data {
                DispatchQueue.main.async {
                    completionHandler(data,nil)
                }
            }
        }
        dataTask.resume()
        
    }
    
    func loadImage(_ endpoint:MAEndpoint, completionHandler: @escaping WebServiceResponse) {
        
        guard let url = endpoint.imageUrl else {
            completionHandler(nil,nil)
            return
        }
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data {
                DispatchQueue.main.async {
                    completionHandler(data,nil)
                }
            }
        }
        dataTask.resume()
        
    }
    
}
