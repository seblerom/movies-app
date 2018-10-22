//
//  MAFileManager.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

class MAFileManager {
    
    static func save<T:Encodable>(_ path:String,_ object:T) -> Void {
        
        let url = URL(fileURLWithPath: path, relativeTo: FileManager.default.cacheDirectoryURL)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func get<T:Decodable>(_ path:String,object:T.Type) -> T? {
        
        let url = URL(fileURLWithPath: path, relativeTo: FileManager.default.cacheDirectoryURL)
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf:url)
            let model = try decoder.decode(object, from: data)
            return model
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
