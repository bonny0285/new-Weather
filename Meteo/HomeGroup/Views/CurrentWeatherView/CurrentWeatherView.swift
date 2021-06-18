//
//  CurrentWeatherView.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 19/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

//class CurrentWeatherView: UIView {
//
//    //MARK: - Outlets
//
//    @IBOutlet weak var contentView: UIView!
//    @IBOutlet weak var locationName: UILabel!
//    @IBOutlet weak var population: UILabel!
//    @IBOutlet weak var sunriseImage: UIImageView!
//    @IBOutlet weak var sunriseTime: UILabel!
//    @IBOutlet weak var sunsetImage: UIImageView!
//    @IBOutlet weak var sunsetTime: UILabel!
//    @IBOutlet weak var degrees: UILabel!
//    @IBOutlet weak var weatherImage: UIImageView!
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//        private func commonInit() {
//            Bundle.main.loadNibNamed( "CurrentWeatherView", owner: self, options: nil)
//            addSubview(contentView)
//            contentView.backgroundColor = .clear
//            contentView.translatesAutoresizingMaskIntoConstraints = false
//            contentView.frame = self.bounds
//            contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//            contentView.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        }
//}
//
//
//extension CurrentWeatherView {
//    
//    func setupCurrentWeatherView(_ weather: MainWeather) {
//        locationName.text = weather.name
//        let populationText = NSLocalizedString("population_label", comment: "")
//        population.text = "\(populationText)\(weather.population)"
//        sunriseImage.image = UIImage(named: "new_sunrise")
//        sunsetImage.image = UIImage(named: "new_sunset")
//        sunsetTime.text = weather.getSunset
//        sunriseTime.text = weather.getSunrise
//        degrees.text = "\(weather.temperatureString) °C"
//        weatherImage.image = UIImage(named: weather.setImageAtCondition)
//    }
//    
//    func setupColorViewAtCondition(_ condition: MainWeather.WeatherCondition) {
//        
//        switch condition {
//        case .tempesta:
//            locationName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            population.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunriseImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunsetImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            degrees.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunriseTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunsetTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .pioggia:
//            locationName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            population.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            degrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .pioggiaLeggera:
//            locationName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            population.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            degrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .neve:
//            locationName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            population.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunriseImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunsetImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            degrees.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunriseTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            sunsetTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .nebbia:
//            locationName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            population.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            degrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .sole:
//            locationName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            population.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            degrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .nuvole:
//            locationName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            population.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            degrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunriseTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            sunsetTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        }
//    }
//}
