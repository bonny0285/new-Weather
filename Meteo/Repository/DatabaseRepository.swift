//
//  DatabaseRepository.swift
//  Meteo
//
//  Created by Massimiliano on 01/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseRepository {
    
    func save(_ citiesList: [CitiesList]) {}
    
//    func saveWeather(_ cityName: String, _ latitude: Double, _ longitude: Double) {
//        
//        do {
//            let realm = try Realm.init()
//            
//            let weather = RealmWeatherManager.init()
//            weather.name = cityName
//            weather.latitude = latitude
//            weather.longitude = longitude
//            
//            let results = realm.objects(RealmWeatherManager.self)
//            
//            if results.count == 10 {
//                delegate?.setupNavigationBar(results.count, true, false)
//            } else {
//                try realm.write {
//                    realm.add(weather)
//                    delegate?.setupNavigationBar(results.count + 1, true, true)
//                    debugPrint("ITEM ADDED: \(cityName)")
//                }
//            }
//        } catch let error {
//            debugPrint(error.localizedDescription)
//        }
//    }
}
