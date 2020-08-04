//
//  FetchWeather.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class FetchWeather {
    
    //var delegate: WeatherDelegate?
    var weatherCondition: WeatherCondition = .sole
    var citiesResult: [CitiesList] = []
    
    
    
    func getMyWeatherData(forLatitude latitude: Double, forLongitude longitude: Double, completion: @escaping (WeatherStruct, [WeatherCell]) -> (Void)?){
        print(#function)
        
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric") else { return }
        
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json: JSON = JSON(arrayLiteral: value)
                debugPrint(json)
                let weather = self.parseJSON(forJSON: json)
                //self.delegate?.getData(weather: weather)
                let weatherCell = self.weatherJSONForCell(forJSON: json)
                //self.delegate?.getDataForCell(weather: weatherCell)
                completion(weather, weatherCell)
            case .failure(let error):
                print(error.localizedDescription)
                MyAlert.alertError(forError: error.localizedDescription, forViewController: MainViewController())
            }
        }
    }
    
    
    //MARK: - ParseJSON
   fileprivate func parseJSON(forJSON json: JSON) -> WeatherStruct{
        debugPrint(#function)
        let name = "\(json[0]["city"]["name"])"
        let population = Int("\(json[0]["city"]["population"])") ?? 0
        let country = "\(json[0]["city"]["country"])"
        let id = Int("\(json[0]["list"][0]["weather"][0]["id"])") ?? 0
        let temperature = Double("\(json[0]["list"][0]["main"]["temp"])") ?? 0.0
        
        let weather = WeatherStruct(nome: name, population: population, country: country, temperature: temperature, conditionId: id)
        return weather
    }
    
    
    
    //MARK: - WeatherJSONForCell
    fileprivate func weatherJSONForCell(forJSON json: JSON) -> [WeatherCell]{
        
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
    
    
    func getJSONFromList(city: String, completion: @escaping ([CitiesList]) -> (Void)) {
        
        citiesResult.removeAll()
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            print(result[0])
            for (index, element) in result.enumerated() {
                if result[index].name == city {
                    print("TROVATO",element)
                    citiesResult.append(element)
                } else {
                    //print("NESSUNA CITTÀ")
                }
            }
            completion(citiesResult)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    
    
    
    //MARK: - GetMyWeatherDataByCity
    func getMyWeatherDataByCity(forCity city: String, completion: @escaping (WeatherStruct, [WeatherCell]) -> (Void)?){
            
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric&q=\(city)") else { return }
            
            AF.request(url).responseJSON { (response) in
                switch response.result{
                case .success(let value):
                    
                    let json: JSON = JSON(arrayLiteral: value)
                    print(json)
                    let coordinate = self.getCoordinate(forJSON: json)
                    self.getMyWeatherData(forLatitude: coordinate.0, forLongitude: coordinate.1, completion: { weather, weatherCell in
                        completion(weather, weatherCell)
                    })
                case .failure(let error):
                    print(error.localizedDescription)
                    MyAlert.alertError(forError: error.localizedDescription, forViewController: MainViewController())
                }
            }
        }
     
        
        
    //MARK: - GetCoordinate
        func getCoordinate(forJSON json: JSON) -> (Double,Double){
            let latitude = Double("\(json[0]["coord"]["lat"])") ?? 0.0
            let longitude = Double("\(json[0]["coord"]["lon"])") ?? 0.0
            let coordinate = (latitude,longitude)
            return coordinate
        }
        
        
        
     //MARK: - ParseJSONByCity
        func parseJSONByCity(forJSON json: JSON) -> WeatherStruct{
            
            let name = json[0]["name"]
            let id = Int("\(json[0]["weather"][0]["id"])")
            let temperature = Double("\(json[0]["main"]["temp"])")
            let population = 0
            let country = ""
            let weather = WeatherStruct(nome: "\(name)", population: population, country: country, temperature: temperature!, conditionId: id!)
            return weather
        }
        
        
        
    //MARK: - SetImageBackground
    func setImageBackground(forID id: Int) -> String{
            
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

    extension FetchWeather {
        enum WeatherCondition: String {
            case tempesta = "tempesta"
            case pioggia = "pioggia"
            case neve = "neve"
            case nebbia = "nebbia"
            case sole = "sole"
            case nuvole = "nuvole"
            
            
            func getWeatherConditionFromID(weatherID: Int) -> WeatherCondition {
                var condition = self
                switch weatherID {
                case 0...300, 772...799, 900...903, 905...1000:
                    condition = .tempesta
                case 301...500, 501...599:
                    condition = .pioggia
                case 600...700, 903:
                    condition = .neve
                case 701...771:
                    condition = .nebbia
                case 800, 904:
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

    
    
    
    
