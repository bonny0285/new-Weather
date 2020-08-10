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
    func retriveResultsDidFinished(_ weather: WeatherModel)
}


class RealmManager {
    
    var delegate: RealmManagerDelegate?
    var fetchManager = FetchWeather()
    
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
    
    
    func retriveWeather() {
        //var weatherResult: [WeatherModel] = []
        
        do {
            let realm = try Realm.init()
            
            let results = realm.objects(RealmWeatherManager.self)
            
            for i in results {
                DispatchQueue.main.async {
                    self.fetchManager.getMyWeatherData(forLatitude: i.latitude, forLongitude: i.longitude) { (weather) in
                    self.delegate?.retriveResultsDidFinished(weather)
                }
                }
            }
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
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
