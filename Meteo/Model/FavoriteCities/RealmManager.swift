//
//  RealmManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


protocol RealmWeatherManagerDelegate: class {
    func retriveResultsDidFinished(_ weather: WeatherGeneralManager)
    func retriveEmptyResult()
}


class RealmManager {
    
    var delegation: RealmWeatherManagerDelegate?
    var weatherFetchManager: WeatherFetchManager?
    var weatherGeneralManager: WeatherGeneralManager?
    var isElementsAreEmpty: Bool = false
    
    func saveWeather(_ cityName: String, _ latitude: Double, _ longitude: Double) {
        
        do {
            let realm = try Realm.init()
            
            let weather = RealmWeatherManager.init()
            weather.name = cityName
            weather.latitude = latitude
            weather.longitude = longitude
            
            try realm.write {
                realm.add(weather)
                debugPrint("ITEM ADDED: \(cityName)")
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
   
//
//    func retriveWeatherForFetchManager(completion: @escaping() -> ()) {
//
//        do {
//            let realm = try Realm.init()
//
//            let results = realm.objects(RealmWeatherManager.self)
//
//            if results.count == 0 {
//                isElementsAreEmpty = true
//            } else {
//                isElementsAreEmpty = false
//            }
//
//            for i in results {
//                weatherFetchManager = WeatherFetchManager(latitude: i.latitude, longitude: i.longitude){ weatherManager in
//                    self.weatherGeneralManager = weatherManager
//                    self.delegation?.retriveResultsDidFinished(weatherManager)
//                }
//
//                completion()
//            }
//
//        } catch let error {
//            debugPrint(error.localizedDescription)
//        }
//    }

    func checkForLimitsCitySaved(completion: @escaping (Bool) -> ()) {
        var isLimitBeenOver: Bool = false
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            if results.count == 10 {
                isLimitBeenOver = true
                completion(isLimitBeenOver)
            } else {
                isLimitBeenOver = false
                completion(isLimitBeenOver)
            }
   
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func checkForAPresentLocation(city: String, completion: @escaping (Bool) -> ()) {
        var isPresent: Bool = false
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            for elemant in results {
                if elemant.name == city {
                    isPresent = true
                    break
                } else {
                    isPresent = false
                }
            }
   
            completion(isPresent)
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    
    func retriveWeatherForFetchManager() {
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            if results.count == 0 {
                isElementsAreEmpty = true
                delegation?.retriveEmptyResult()
            } else {
                isElementsAreEmpty = false
            }

            for i in results {
                weatherFetchManager = WeatherFetchManager(latitude: i.latitude, longitude: i.longitude){ weatherManager in
                    self.delegation?.retriveResultsDidFinished(weatherManager)
                }
                
            }
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func deleteWeather(_ index: IndexPath) {
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            try realm.write {
                realm.delete(results[index.row])
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
}
