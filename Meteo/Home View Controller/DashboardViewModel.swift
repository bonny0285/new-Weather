//
//  DashboardViewModel.swift
//  Meteo
//
//  Created by Massimiliano on 24/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation
import Combine

protocol DashboardViewModelDelegate: AnyObject {
    func openSideMenu()
}


class DashboardViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private var language: String { Locale.current.languageCode! }
    private var weatherRepository = WeatherRepository()
    private(set) var latitude: Double = 0.0
    private(set) var longitude: Double = 0.0
    @Published var _weatherObject: JSONObject?
    weak var delegate: DashboardViewModelDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    
}

extension DashboardViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            latitude = lat
            let lon = location.coordinate.longitude
            longitude = lon
            
            weatherRepository.fetchWeather(latitude: lat, longitude: lon, language: language) { [weak self] result in
                guard let self = self else { return }
                self._weatherObject = result
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
}
