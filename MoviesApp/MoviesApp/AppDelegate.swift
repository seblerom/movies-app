//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Sebastian Leon on 20/10/2018.
//  Copyright © 2018 seblerom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstViewController = MAMoviesListViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: firstViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


class Config {

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
    
    func retrieveConfiguration(completion:@escaping(_ configModel:MAApiImagesConfigurationModel?) -> Void) {
        
        let fileManager = MAFileManager()
        
        if let data = fileManager.get(MAConstants.Configuration.file) {
            if let previousDate = UserDefaults.standard.getDate() {
                if dateGratherThan(previousDate) {
                    configurationRequest { (data, error) in
                        if error == nil, let data = data {
                            completion(self.decode(data))
                        }
                        completion(nil)
                    }
                }else{
                    completion(decode(data))
                }
            }
        }else{
            configurationRequest { (data, error) in
                if error == nil, let data = data {
                    completion(self.decode(data))
                }
                completion(nil)
            }
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
        
        if let days = components.day,days > 7 {
            return true
        }
        return false
        
    }
}
