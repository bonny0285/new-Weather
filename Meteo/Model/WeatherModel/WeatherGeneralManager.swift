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
    var weathersCell: [WeatherGeneralManagerCell]
    var citiesList: [CitiesList]
    
    init(name: String, population: Int, country: String, temperature: Double, conditionID: Int, weathersCell: [WeatherGeneralManagerCell],citiesList: [CitiesList]) {
        self.name = name
        self.population = population
        self.country = country
        self.temperature = temperature
        self.conditionID = conditionID
        self.weathersCell = weathersCell
        self.citiesList = citiesList
    }
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
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
    
    /// condition ID per immagini iOS 13
    var conditionName : String {
        switch conditionID {
        case 200 ... 232:
            return "cloud.bolt"
        case 300 ... 321:
            return "cloud.drizzle"
        case 500 ... 531:
            return "cloud.rain"
        case 600 ... 622:
            return "cloud.snow"
        case 701 ... 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801 ... 804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
    
    
    /// condition ID per immagini infieriore iOS 13
    var conditionNameOldVersion: String{
        switch conditionID {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "unknown"
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


