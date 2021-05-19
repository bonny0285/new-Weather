//
//  DashboardViewController.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation
import Combine

class DashboardViewController: UIViewController {
    
    //MARK: - Outlets
    // TOP VIEW
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var mainWeatherImage: UIImageView!
    
    // BOTTOM LABEL
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    //MARK: - Properties
    
    var language: String { Locale.current.languageCode! }
    let locationManager = CLLocationManager()
    private var cancellable: AnyCancellable?
    private var weatherRepository = WeatherRepository()
    private var weathers: JSONObject!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //MARK: - Methods

    
    //MARK: - Actions


}

//MARK: - CLLocationManagerDelegate

extension DashboardViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherRepository.fetchWeather(latitude: lat, longitude: lon, language: language) { result in
                print("RESULT: \(result)")
                
                DispatchQueue.main.async {
                    self.degreesLabel.text = result.list.first?.main.temp.temperatureString
                    self.cityNameLabel.text = result.city.name
                    self.populationLabel.text = "Population: \(result.city.population)"
                    self.mainWeatherImage.image = (result.list.first?.weather.first?.id.weatherImage)
                    self.sunriseLabel.text = result.city.sunrise.transformTimestampToString()
                    self.sunsetLabel.text = result.city.sunset.transformTimestampToString()
                }
                
            }
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
}


extension Double {
    func transformTimestampToString() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //formatter.timeStyle = .short
        let string = formatter.string(from: date as Date)
        return string
    }
    
    var temperatureString: String {
        String(format: "%.1f", self)
    }
}

extension Int {
    
    
    
    var weatherImage : UIImage? {
        switch self {
        case 200...202, 210...212, 221 ,230...232:
            return UIImage(named: "new_tempesta")
        case 300...302, 310...314, 321:
            return UIImage(named: "new_pioggia_leggera")
        case 500...504, 511, 520...522, 531:
            return UIImage(named: "new_pioggia")
        case 600...602, 611...613, 615, 616, 620...622:
            return UIImage(named: "new_neve")
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return UIImage(named: "new_nebbia")
        case 800:
            return UIImage(named: "new_sun")
        case 801 ... 804:
            return UIImage(named: "new_cloud")
        default:
            return UIImage(named: "cloud")
        }
    }
}
