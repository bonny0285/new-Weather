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
    
    @IBOutlet weak var mainWeatherImage: UIImageView!
    
    // MIDDLE SCROLL VIEW
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
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

    private func setupMiddleWeatherCards(with list: [List]) {
        horizontalScrollView.subviews.forEach { $0.removeFromSuperview() }
        
        var containerView: [UIView] = []
        
        for i in 0 ..< list.count {
            let middleView = WeatherMiddleView()
            middleView.viewModel = WeatherMiddleView.ViewModel(
                weatherImage: UIImage(named: getWeatherConditionFromID(weatherID: list[i].weather.first!.id).rawValue)!,
                weatherTime: list[i].txt.stringDateString,
                weatherDescription: list[i].weather.first!.description,
                tempMax: list[i].main.temp_max.temperatureString,
                tempMin: list[i].main.temp_min.temperatureString
            )
            
            let containerMiddleView = UIView()
            containerMiddleView.addSubview(middleView)
            
            middleView.translatesAutoresizingMaskIntoConstraints = false
            middleView.heightAnchor.constraint(equalToConstant: horizontalScrollView.frame.height).isActive = true
            //middleView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor, constant: 0).isActive = true
            middleView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            middleView.topAnchor.constraint(equalTo: containerMiddleView.topAnchor).isActive = true
            middleView.bottomAnchor.constraint(equalTo: containerMiddleView.bottomAnchor).isActive = true
            middleView.trailingAnchor.constraint(equalTo: containerMiddleView.trailingAnchor).isActive = true
            middleView.leadingAnchor.constraint(equalTo: containerMiddleView.leadingAnchor).isActive = true
            
            containerView.append(containerMiddleView)
        }
        
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.contentSize = CGSize(
            width: Int(self.view.frame.width) * list.count,
            height: 1
        )
        
        let stack = UIStackView(arrangedSubviews: containerView)
        stack.axis = .horizontal
        
        horizontalScrollView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor).isActive = true 
        stack.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 0).isActive = true
        stack.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 0).isActive = true
        stack.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor, constant: 0).isActive = true
        stack.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: 0).isActive = true
    }
    
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
                    let temp = result.list.first!.main.temp.temperatureString
                    self.title = "\(result.city.name) \(temp)°C"
                    self.populationLabel.text = "Population: \(result.city.population)"
                    self.mainWeatherImage.image = (result.list.first?.weather.first?.id.weatherImage)
                    self.sunriseLabel.text = result.city.sunrise.transformTimestampToString()
                    self.sunsetLabel.text = result.city.sunset.transformTimestampToString()
                    
                    self.setupMiddleWeatherCards(with: result.list)
                }
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
    
    
    enum WeatherCondition: String {
        case tempesta = "tempesta"
        case pioggia = "pioggia"
        case pioggiaLeggera = "pioggia_leggera"
        case neve = "neve"
        case nebbia = "nebbia"
        case sole = "sole"
        case nuvole = "nuvole"
    }
        
        func getWeatherConditionFromID(weatherID: Int) -> WeatherCondition {
            var condition = self
            switch weatherID {
            case 200...202, 210...212, 221 ,230...232:
                return .tempesta
                
            case 300...302, 310...314, 321:
                return .pioggiaLeggera
                
            case 500...504, 511, 520...522, 531:
                return .pioggia
                
            case 600...602, 611...613, 615, 616, 620...622:
                return .neve
                
            case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                return .nebbia
                
            case 800:
                return .sole
                
            case 801...804:
                return .nuvole
                
            default:
                return .nuvole
            }
            //return condition
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

extension String {
    var temperatureString: String {
        String(format: "%.1f", self)
    }
    
    var stringDateString: String {
       let dateFormatter1 = DateFormatter()
       dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
       let dateFromString = dateFormatter1.date(from: self)
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "HH:mm E, d MMM y"
       //dateFormatter.dateFormat = "dd'/'MM'/'yyyy' 'HH':'mm':'ss"
       let date = dateFormatter.string(from: dateFromString!)
       return date
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
