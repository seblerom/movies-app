//
//  MAConfiguration.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 22/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import Foundation

class MAConfiguration {
    
    static let serialQueueName = "com.moviesapp.configuration.queue"
    let serialQueue = DispatchQueue.init(label: serialQueueName, qos: .background)
    
    func asynchronousConfigurationDataSource(completion:@escaping(_ configuration:MAApiImagesConfigurationModel?)-> Void) {
        
        self.serialQueue.async {
            self.retrieveConfiguration(completion: { (model) in
                DispatchQueue.main.async {
                    completion(model)
                }
            })
        }
    }
    
    func retrieveConfiguration(completion:@escaping(_ configModel:MAApiImagesConfigurationModel?) -> Void) {
        
        guard let model = MAFileManager.get(MAConstants.Configuration.file, object: MAApiImagesConfigurationModel.self) else {
            
            retrieveConfigurationFromServer(completion: { completion($0) })
            return
        }
        
        if let previousDate = UserDefaults.standard.getDate() {
            if dateGratherThan(previousDate) {
                retrieveConfigurationFromServer(completion: {completion($0)})
            }else{
                completion(model)
            }
        }else {
            retrieveConfigurationFromServer(completion: {completion($0)})
        }
        
    }
    
    func retrieveConfigurationFromServer(completion:@escaping(_ configuration:MAApiImagesConfigurationModel?)-> Void ) {
        
        let netWorkClient = MANetworkClientDecodable<MAApiImagesConfigurationModel>()
        netWorkClient.execute(.configuration()) { (result) in
            
            switch result {
            case .failure(let error):
                print(error.reason)
                completion(nil)
            case .success(let response):
                DispatchQueue.global(qos: .background).async(execute: {
                    //Save to disk
                    MAFileManager.save(MAConstants.Configuration.file, response as? MAApiImagesConfigurationModel)
                    //Save date to user defaults
                    UserDefaults.standard.save(Date())
                })
                completion(response as? MAApiImagesConfigurationModel)
            }
        }

    }
    
    func dateGratherThan(_ savedDate:Date) -> Bool {
        
        let calendar = NSCalendar.current
        let previousDate = calendar.startOfDay(for: savedDate)
        let currentDate = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: previousDate, to: currentDate)
        
        // 7 is an arbitrary value, according to themoviedb
        // documentation, the config is something to check
        // every now and then.
        if let days = components.day,days > 7 {
            return true
        }
        return false
        
    }
}

