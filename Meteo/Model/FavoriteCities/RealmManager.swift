//
//  RealmManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


protocol RealmManagerDelegate: class {
    func retriveWeatherDidFinisched(_ weather: Results<RealmWeatherManager>)
    func retriveIsEmpty(_ isEmpty: Bool)
    func locationDidSaved(_ isPresent: Bool)
    func isLimitDidOver(_ isLimitOver: Bool)
}




class RealmManager {
    
    var delegate: RealmManagerDelegate?
   
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
                delegate?.isLimitDidOver(true)
            } else {
                try realm.write {
                    realm.add(weather)
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
            delegate?.isLimitDidOver(isLimitBeenOver)
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func checkForAPresentLocation(city: String) {
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
            delegate?.locationDidSaved(isPresent)
            
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
                delegate?.retriveIsEmpty(true)
            } else {
                isElementsAreEmpty = false
                delegate?.retriveWeatherDidFinisched(results)

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
