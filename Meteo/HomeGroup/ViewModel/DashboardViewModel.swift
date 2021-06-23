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
import RealmSwift
import SPMNetworkRepository

protocol DashboardViewModelDelegate: AnyObject {
    func openSideMenu(parent: UIViewController & SideMenuViewControllerDelegate, height: CGFloat, width: CGFloat, navigationBarHeight: CGFloat)
    func openSearchViewController()
    func openSavedViewController()
    func closeSideMenu()
}

class DashboardViewModel: NSObject {
    
    //MARK: - Properties

    private let locationManager = CLLocationManager()
    private var language: String { Locale.current.languageCode! }
    private(set) var latitude: Double = 0.0
    private(set) var longitude: Double = 0.0
    @Published var _weatherObject: JSONObject?
    weak var delegate: DashboardViewModelDelegate?
    let defaults = UserDefaults.standard
    
    //MARK: - Lifecycle

    override init() {
        super.init()
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestLocation()
    }
    
    private func saveUserLocation(latitude: Double, longitude: Double) {
        defaults.set(latitude, forKey: "latitude")
        defaults.set(longitude, forKey: "longitude")
    }
    
    func fetchCities(completion: @escaping (Result<[String : [CityBulk]], Error>) -> ()) {
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")!
                
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            let result = try JSONDecoder().decode([CityBulk].self, from: data)//.sorted { $0.name < $1.name}.compactMap { $0 }//.filter { $0.name.starts(with: text) }
            let cities = result.filter { $0.name != "" }
            let dict: [String : [CityBulk]] = Dictionary(grouping: cities, by: { String($0.name.first!) })
            completion(.success(dict))
            
        } catch let error {
            completion(.failure(error))
        }
    }
    
}

extension DashboardViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.requestLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            latitude = lat
            let lon = location.coordinate.longitude
            longitude = lon
            
            let url = URL(string:  "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(language)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric")!
            
            let networkRepository = NetworkRepository(url: url)
            
            networkRepository.fetch { [weak self] (result: Result<JSONObject,Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success( let value):
                    print(value)
                    self._weatherObject = value
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
}
