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
    
    func asynchronousConfigurationDataSource(completion:@escaping(_ configuration:MAApiImagesConfigurationModel)-> Void) {
        
        self.serialQueue.async {
            self.retrieveConfiguration(completion: { (model) in
                guard let model = model else { return }
                completion(model)
            })
        }
    }
    
    func decode(_ data:Data) -> MAApiImagesConfigurationModel? {
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(MAApiImagesConfigurationModel.self, from: data)
    }
    
    private func requestConfiguration(_ completion: @escaping (MAApiImagesConfigurationModel?) -> Void) {
        configurationRequest { (data, error) in
            if error == nil, let data = data {
                completion(self.decode(data))
            }
            completion(nil)
        }
    }
    
    func retrieveConfiguration(completion:@escaping(_ configModel:MAApiImagesConfigurationModel?) -> Void) {
        
        let fileManager = MAFileManager()
        
        if let data = fileManager.get(MAConstants.Configuration.file) {
            if let previousDate = UserDefaults.standard.getDate() {
                if dateGratherThan(previousDate) {
                    requestConfiguration(completion)
                }else{
                    completion(decode(data))
                }
            }
        }else{
            requestConfiguration(completion)
        }
        
    }
    
    func configurationRequest(completion:@escaping(_ data:Data?,_ error:Error?)-> Void ) {
        let netWorkClient = MANetworkClient()
        netWorkClient.execute(.configuration()) { (data, error) in
            
            if error == nil,let data = data {
                
                let fileManager = MAFileManager()
                DispatchQueue.global(qos: .background).async(execute: {
                    //Save to disk
                    fileManager.save(MAConstants.Configuration.file, data: data)
                    //Save date to user defaults
                    UserDefaults.standard.save(Date())
                })
                completion(data,nil)
            }
            completion(nil,error)
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
