//
//  RealmManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


/// aggiungere il delegate del weather realm manager


class RealmManager {
    
    var delegate: WeatherRealmManagerDelegate?
   
    //var weatherFetchManager: WeatherFetchManager?
    var weatherGeneralManager: [MainWeather] = []
    var isElementsAreEmpty: Bool = false
    
    
    
    
    
    func saveWeather(_ cityName: String, _ latitude: Double, _ longitude: Double) {
        
        do {
            let realm = try Realm.init()
            
            let weather = RealmWeatherManager.init()
            weather.name = cityName
            weather.latitude = latitude
            weather.longitude = longitude
            
            let results = realm.objects(RealmWeatherManager.self)
            
            if results.count == 10 {
                delegate?.setupNavigationBar(results.count, true, false)
            } else {
                try realm.write {
                    realm.add(weather)
                    delegate?.setupNavigationBar(results.count + 1, true, true)
                    debugPrint("ITEM ADDED: \(cityName)")
                }
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    
    
 
    func checkForLimitsCitySaved() {
        var isLimitBeenOver: Bool = false
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
                if results.count == 10 {
                    isLimitBeenOver = true
                    
                } else {
                    isLimitBeenOver = false
                    
                }
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func checkForAPresentLocation(city: String) -> Bool {
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
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return isPresent
    }
    
    
    func retriveWeatherForFetchManager() {
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            switch results.count {
            case 0:
                delegate?.setupNavigationBar(results.count, false, true)
            case 1 ... 9:
                delegate?.setupNavigationBar(results.count, true, true)
            case 10:
                delegate?.setupNavigationBar(results.count, true, false)
            default:
                break
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
//    func deleteWeather(_ index: IndexPath) {
//
//        do {
//            let realm = try Realm.init()
//
//            let results = realm.objects(RealmWeatherManager.self)
//
//            try realm.write {
//                realm.delete(results[index.row])
//            }
//        } catch let error {
//            debugPrint(error.localizedDescription)
//        }
//
//    }
    
    func deleteWeather(_ city: String) {
        
        var weatherToDelete: RealmWeatherManager? = nil
        
        do {
            let realm = try Realm.init()
            let results = realm.objects(RealmWeatherManager.self)
            
            if results.count > 0 {
                for res in results {
                    if res.name == city {
                        weatherToDelete = res
                        break
                    }
                }
                
                try realm.write {
                    realm.delete(weatherToDelete!)
                }
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }

}
