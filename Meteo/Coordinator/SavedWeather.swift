//
//  SavedWeather.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


protocol SavedWeatherDelegate: class {
    func retriveDidFinished()
}

class SavedWeather {

    
    //MARK: - Main Private Properties
    var realmManager: RealmManager?
    private var weatherFetchManager: WeatherFetchManager?
    
    weak var delegate: SavedWeatherDelegate?
    
    //MARK: - Realm
    var isDatabaseEmpty: Bool? = nil
    var isLocationSaved: Bool? = nil
    var isLimitOver: Bool? = nil
    var weatherResults: Results<RealmWeatherManager>? = nil
    
    //MARK: - MainWeather
    var retriveWeathers: [MainWeather]? = nil
    var retriveWeathersError: String? = nil
    
    
    init() {
        realmManager = RealmManager()
        realmManager?.delegate = self
        realmManager?.retriveWeatherForFetchManager()
        realmManager?.checkForLimitsCitySaved()
    }
}


extension SavedWeather: RealmManagerDelegate {
    
    func retriveWeatherDidFinisched(_ weather: Results<RealmWeatherManager>) {
        self.weatherResults = weather
        
        guard let result = self.weatherResults else { return }
        self.weatherFetchManager = WeatherFetchManager()
        self.weatherFetchManager?.delegate = self
        self.weatherFetchManager?.retriveMultipleLocation(for: result)
        
    }
    
    func retriveIsEmpty(_ isEmpty: Bool) {
        self.isDatabaseEmpty = true
    }
    
    func locationDidSaved(_ isPresent: Bool) {
        self.isLocationSaved = isPresent
    }
    
    func isLimitDidOver(_ isLimitOver: Bool) {
        self.isLimitOver = isLimitOver
    }
}


extension SavedWeather: WeatherFetchManagerPreferedDelegate {
    func getArrayData(_ weather: [MainWeather]) {
        self.retriveWeathers = weather
        self.delegate?.retriveDidFinished()
    }
    
    func didGetError(_ error: String) {
        self.retriveWeathersError = error
    }
}
