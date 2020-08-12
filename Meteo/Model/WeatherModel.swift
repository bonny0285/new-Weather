//
//  WeatherModel.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 10/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

struct WeatherModelCell {
    var temperatureMax: Double
    var temperatureMin: Double
    var conditionID: Int
    var description: String
    var time: String
    
    
    
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

struct WeatherModel {
    
    var name: String
    var population: Int
    var country: String
    var temperature: Double
    var conditionID: Int
    var weatherForCell: [WeatherModelCell]
    var condition: FetchWeatherManager.WeatherCondition
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
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
