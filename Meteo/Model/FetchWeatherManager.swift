//
//  FetchWeatherManager.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 12/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FetchWeatherManager {
    
    var weather: WeatherModel!
    fileprivate var weatherCondition: WeatherCondition = .sole
    
    
    init(latitude: Double, longitude: Double, completion: @escaping (WeatherModel) -> ())  {
        DispatchQueue.main.async {
            self.getMyWeatherData(forLatitude: latitude, forLongitude: longitude) {
                self.weather = $0
                completion($0)
            }
        }
    }
    
    private func getMyWeatherData(forLatitude latitude: Double, forLongitude longitude: Double, completion: @escaping (WeatherModel) -> ()){
        
        guard let language = Locale.current.languageCode else { return }
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(language)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric") else { return }
        
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json: JSON = JSON(arrayLiteral: value)
                debugPrint(json)
                let weather = self.JSONTransform(json)
                
                completion(weather)
                
            case .failure(let error):
                print(error.localizedDescription)
                MyAlert.alertError(forError: error.localizedDescription, forViewController: MainViewController())
            }
        }
    }
    
    

    fileprivate func JSONTransform(_ json: JSON) -> WeatherModel {
        let name = "\(json[0]["city"]["name"])"
        let population = Int("\(json[0]["city"]["population"])") ?? 0
        let country = "\(json[0]["city"]["country"])"
        let temperature = Double("\(json[0]["list"][0]["main"]["temp"])") ?? 0.0
        let id = Int("\(json[0]["list"][0]["weather"][0]["id"])") ?? 0
        
        
        let list = json[0]["list"]
        
        var weatherCell: [WeatherModelCell] = []
        for i in 0 ... list.count - 1{
            let temperatureMax = Double("\(json[0]["list"][i]["main"]["temp_max"])")!
            let temperatureMin = Double("\(json[0]["list"][i]["main"]["temp_min"])")!
            let weatherID = Int("\(json[0]["list"][i]["weather"][0]["id"])")!
            let description = "\(json[0]["list"][i]["weather"][0]["description"])"
            let time = "\(json[0]["list"][i]["dt_txt"])"
            
            let cell = WeatherModelCell(temperatureMax: temperatureMax, temperatureMin: temperatureMin, conditionID: weatherID, description: description, time: time)
            weatherCell.append(cell)
        }
        
        let weather = WeatherModel(name: name, population: population, country: country, temperature: temperature, conditionID: id, weatherForCell: weatherCell, condition: weatherCondition.getWeatherConditionFromID(weatherID: id))
        
        return weather
    }
}


    extension FetchWeatherManager {
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
