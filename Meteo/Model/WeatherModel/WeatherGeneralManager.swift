//
//  WeatherGeneralManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 14/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit




class WeatherGeneralManager {
    let name: String
    let population: Int
    let country: String
    let temperature: Double
    var conditionID: Int
    var sunset: Double
    var sunrise: Double
    var weathersCell: [WeatherGeneralManagerCell]
    
    init(name: String, population: Int, country: String, temperature: Double, conditionID: Int, sunset: Double, sunrise: Double, weathersCell: [WeatherGeneralManagerCell]) {
        self.name = name
        self.population = population
        self.country = country
        self.temperature = temperature
        self.conditionID = conditionID
        self.weathersCell = weathersCell
        self.sunset = sunset
        self.sunrise = sunrise
    }
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
    var getSunrise: String {
        let date = NSDate(timeIntervalSince1970: sunrise)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //formatter.timeStyle = .short
        let string = formatter.string(from: date as Date)
        return string
    }
    
    var getSunset: String {
        let date = NSDate(timeIntervalSince1970: sunset)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //formatter.timeStyle = .short
        let string = formatter.string(from: date as Date)
        return string
    }
    
    var condition: WeatherCondition {
        var condition: WeatherCondition = .nebbia
        switch conditionID {
            case 200...202, 210...212, 221 ,230...232:
                 condition = .tempesta
            case 300...302, 310...314, 321:
                condition = .pioggiaLeggera
            case 500...504, 511, 520...522, 531:
                 condition = .pioggia
            case 600...602, 611...613, 615, 616, 620...622:
                condition = .neve
            case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                condition = .nebbia
            case 800:
                condition = .sole
            case 801...804:
                condition = .nuvole
            default:
                break
        }
        return condition
    }
    
    
    
    var setImageAtCondition : String {
        switch conditionID {
        case 200...202, 210...212, 221 ,230...232:
            return "new_tempesta"
        case 300...302, 310...314, 321:
            return "new_pioggia_leggera"
        case 500...504, 511, 520...522, 531:
            return "new_pioggia"
        case 600...602, 611...613, 615, 616, 620...622:
            return "new_neve"
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return "new_nebbia"
        case 800:
            return "new_sun"
        case 801 ... 804:
            return "new_cloud"
        default:
            return "cloud"
        }
        
    }

    
    

}

extension WeatherGeneralManager {
        enum WeatherCondition: String {
            case tempesta = "tempesta"
            case pioggia = "pioggia"
            case pioggiaLeggera = "pioggia_leggera"
            case neve = "neve"
            case nebbia = "nebbia"
            case sole = "sole"
            case nuvole = "nuvole"
            
            
            func getWeatherConditionFromID(weatherID: Int) -> WeatherCondition {
                var condition = self
                switch weatherID {
                case 200...202, 210...212, 221 ,230...232:
                    condition = .tempesta
                case 300...302, 310...314, 321:
                    condition = .pioggiaLeggera
                case 500...504, 511, 520...522, 531:
                    condition = .pioggia
                case 600...602, 611...613, 615, 616, 620...622:
                    condition = .neve
                case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                    condition = .nebbia
                case 800:
                    condition = .sole
                case 801...804:
                    condition = .nuvole
                default:
                    break
                }
                return condition
            }
            
        }
}


