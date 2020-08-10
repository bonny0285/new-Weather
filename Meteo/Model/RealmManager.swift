//
//  RealmManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


class RealmManager {
    
    func saveWeather(_ cityName: String, _ latitude: Double, _ longitude: Double) {
        
        do {
            let realm = try Realm.init()
            
            let weather = RealmWeatherManager.init()
            weather.name = cityName
            weather.latitude = latitude
            weather.longitude = longitude
            
            try realm.write {
                realm.add(weather)
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    
    func retriveWeather() -> [RealmWeatherManager] {
        var weatherResult: [RealmWeatherManager] = []
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            results.forEach { weatherResult.append($0) }
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        return weatherResult
    }
    
    func deleteWeather(_ index: IndexPath, completion: () -> ()) {
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            try realm.write {
                realm.delete(results[index.row])
            }
            completion()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
}
