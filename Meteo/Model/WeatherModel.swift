//
//  WeatherModel.swift
//  Meteo
//
//  Created by Massimiliano on 03/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


public protocol WeatherDelegate: class {
    func getData(weather: WeatherStruct)
    func getDataForCell(weather: [WeatherCell])
}


public struct WeatherModel{
    
    
    public static var delegate: WeatherDelegate?
    
    public static func getMyWeatherData(forLatitude latitude: Double, forLongitude longitude: Double){
        print(#function)
        
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric") else { return }
        
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                
                let json: JSON = JSON(arrayLiteral: value)
                print(json)
                let weather = parseJSON(forJSON: json)
                delegate?.getData(weather: weather)
                let weatherCell = weatherJSONForCell(forJSON: json)
                delegate?.getDataForCell(weather: weatherCell)
            case .failure(let error):
                print(error.localizedDescription)
                MyAlert.alertError(forError: error.localizedDescription, forViewController: MainViewController())
            }
        }
    }
    
    
    
   static func parseJSON(forJSON json: JSON) -> WeatherStruct{
    print(#function)
    let name = "\(json[0]["city"]["name"])" ?? ""
    let population = Int("\(json[0]["city"]["population"])") ?? 0
    let country = "\(json[0]["city"]["country"])" ?? ""
    let id = Int("\(json[0]["list"][0]["weather"][0]["id"])") ?? 0
    let temperature = Double("\(json[0]["list"][0]["main"]["temp"])") ?? 0.0
    
    let weather = WeatherStruct(nome: name, population: population, country: country, temperature: temperature, conditionId: id)
    return weather
    }
    
    
    
    
    static func weatherJSONForCell(forJSON json: JSON) -> [WeatherCell]{
        
        let list = json[0]["list"]
        var myArray : [WeatherCell] = []
        
        for i in 0 ... list.count - 1{
            let temperatureMax = Double("\(json[0]["list"][i]["main"]["temp_max"])")!
            let temperatureMin = Double("\(json[0]["list"][i]["main"]["temp_min"])")!
            let weatherID = Int("\(json[0]["list"][i]["weather"][0]["id"])")!
            let description = "\(json[0]["list"][i]["weather"][0]["description"])"
            let time = "\(json[0]["list"][i]["dt_txt"])"
            let weather = WeatherCell(temperatureMax: temperatureMax, temperatureMin: temperatureMin, weatherID: weatherID, weatherDescription: description, weatherTime: time)
            myArray.append(weather)
        }
        
        return myArray
    }
    
    
    public static func getMyWeatherDataByCity(forCity city: String){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric&q=\(city)") else { return }
        
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                
                let json: JSON = JSON(arrayLiteral: value)
                print(json)
                let coordinate = getCoordinate(forJSON: json)
                getMyWeatherData(forLatitude: coordinate.0, forLongitude: coordinate.1)
            case .failure(let error):
                print(error.localizedDescription)
                MyAlert.alertError(forError: error.localizedDescription, forViewController: MainViewController())
            }
        }
    }
    
    static func getCoordinate(forJSON json: JSON) -> (Double,Double){
        let latitude = Double("\(json[0]["coord"]["lat"])") ?? 0.0
        let longitude = Double("\(json[0]["coord"]["lon"])") ?? 0.0
        let coordinate = (latitude,longitude)
        return coordinate
    }
    
    static func parseJSONByCity(forJSON json: JSON) -> WeatherStruct{
        
        let name = json[0]["name"]
        let id = Int("\(json[0]["weather"][0]["id"])")
        let temperature = Double("\(json[0]["main"]["temp"])")
        let population = 0
        let country = ""
        let weather = WeatherStruct(nome: "\(name)", population: population, country: country, temperature: temperature!, conditionId: id!)
        return weather
    }
    
    
    
    
    public static func setImageBackground(forID id: Int) -> String{
        
        switch id {
            
        case 0...300 :
            return "tempesta"
            
        case 301...500 :
            return "pioggia"
            
        case 501...599 :
            return "pioggia"
            
        case 600...700 :
            return "neve"
            
        case 701...771 :
            return "nebbia"
            
        case 772...799 :
            return "tempesta"
            
        case 800 :
            return "sole"
            
        case 801...804 :
            return "nuvole"
            
        case 900...903, 905...1000  :
            return "tempesta"
            
        case 903 :
            return "neve"
            
        case 904 :
            return "sole"
            
        default :
            return "unknown"
        }
    }
    
    
    
    
}
