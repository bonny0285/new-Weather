//
//  WeatherManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 12/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class WeatherManagerModel {
    var arrayName: [String] = []
    var arrayForCell: [WeatherModelCell] = []
    var arrayConditon: [FetchWeatherManager.WeatherCondition] = []
    var arrayImages: [UIImage] = []
    var arrayGradi: [String] = []
    
    func deleteAll() {
        arrayName.removeAll()
        arrayForCell.removeAll()
        arrayConditon.removeAll()
        arrayImages.removeAll()
        arrayGradi.removeAll()
    }
}


class WeatherManager {
    
    var weather = WeatherManagerModel()
    fileprivate var cell: [[WeatherModelCell]] = []
    //fileprivate var fetchWeather = FetchWeather()
    fileprivate var fetchWeatherManager = FetchWeatherManager()
    var isEmptyDataBase: Bool {
        realmManager.isElementsAreEmpty
    }
    fileprivate var realmManager: RealmManager
    
    init(completion: () -> ()) {
        self.realmManager = RealmManager()
        self.realmManager.delegate = self
        self.realmManager.retriveWeather()
        completion()
    }
    
    init() {
        self.realmManager = RealmManager()
        self.realmManager.delegate = self
        self.realmManager.retriveWeather()
    }
}


extension WeatherManager: RealmManagerDelegate {
    func retriveResultsDidFinished(_ weather: WeatherModel) {
        self.cell.append(weather.weatherForCell)
        
        self.weather.arrayGradi.append(weather.temperatureString)
        self.weather.arrayName.append(weather.name)
        self.weather.arrayConditon.append(weather.condition)
        self.weather.arrayImages.append(UIImage(named:self.fetchWeatherManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
            
        //self.weather.arrayImages.append(UIImage(named: self.fetchWeather.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
            
        self.weather.arrayForCell = cell.first!
        
    }
}
