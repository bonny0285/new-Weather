//
//  SmartManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class SmartManager {
    
   // var favoriteWeatherManager: FavoriteWeatherManager?
    var weatherFetchManager: WeatherFetchManager?
    
    var weatherGeneralManager: MainWeather? {
        get {
            weatherFetchManager?.weatherGeneralManager
        }
    }
    
    var latitude: Double
    var longitude: Double
    
    var allCities: AllCitiesList?
    var city: CitiesList?
    
    var savedWeather: SavedWeather
    var weatherSaved: [MainWeather]?
    
    
    init (latitude: Double, longitude: Double, completion: @escaping (MainWeather) -> ()) {
        self.latitude = latitude
        self.longitude = longitude
        //self.favoriteWeatherManager = FavoriteWeatherManager()
        
        self.weatherFetchManager = WeatherFetchManager()
        self.weatherFetchManager?.getMyWeatherData(forLatitude: latitude, forLongitude: longitude, completion: {
            completion($0)
        })
        
        self.savedWeather = SavedWeather()
        self.allCities = AllCitiesList()
    }
    
}

//extension SmartManager: RealmWeatherManagerDelegate {
//    func retriveResultsDidFinished(_ weather: WeatherGeneralManager) {
//
//    }
//
//    func retriveEmptyResult() {
//
//    }
//}
