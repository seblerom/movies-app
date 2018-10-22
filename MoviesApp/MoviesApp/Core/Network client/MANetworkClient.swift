//
//  MANetworkClient.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation


class MANetworkClient {
    
    let session:URLSession
    
    init(session:URLSession = URLSession.shared) {
        self.session = session
    }
    
    typealias WebServiceResponse = (_ model:AnyObject?,_ error:Error?) -> Void
    typealias response = (Result<Any, DataResponseError>) -> ()
    
    func execute(_ endpoint:MAEndpoint,completionHandler: @escaping response) {
        
        guard let url = endpoint.url else {
            completionHandler(Result.failure(DataResponseError.invalidUrl))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data else {
                    completionHandler(Result.failure(DataResponseError.network))
                    return
                }
                
                completionHandler(Result.success(data))
            }
            }.resume()
    }
}

class MANetworkClientDecodable<T:Codable>: MANetworkClient {
    
    override func execute(_ endpoint: MAEndpoint, completionHandler: @escaping response) {
        guard let url = endpoint.url else {
            completionHandler(Result.failure(DataResponseError.invalidUrl))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,let data = data else {
                    completionHandler(Result.failure(DataResponseError.network))
                    return
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(T.self,from:data) else {
                    completionHandler(Result.failure(DataResponseError.decoding))
                    return
                }
                
                completionHandler(Result.success(decodedResponse))
            }
            }.resume()
    }
    
}

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}

enum DataResponseError: Error {
    case network
    case decoding
    case invalidUrl
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .invalidUrl:
            return "The url is invalid"
        }
    }
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
