//
//  MAFileManager.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

class MAFileManager {
    
    func save(_ path:String,data:Data) -> Void {
        
        let url = URL(fileURLWithPath: path, relativeTo: FileManager.default.cacheDirectoryURL)
        do {
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func get(_ path:String) -> Data? {
        
        var data : Data?
        
        let url = URL(fileURLWithPath: path, relativeTo: FileManager.default.cacheDirectoryURL)
        do {
            data = try Data(contentsOf:url)
        } catch let error {
            print(error.localizedDescription)
        }
        return data
    }
    
}
