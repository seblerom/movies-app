//
//  UserDefaults + MoviesApp.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 21/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func save(_ date:Date) {
        set(date,forKey: MAConstants.UserDefaults.dateKey)
        synchronize()
    }
    
    func getDate() -> Date? {
        guard let date = object(forKey: MAConstants.UserDefaults.dateKey) as? Date else {
            return nil
        }
        return date
    }
}
