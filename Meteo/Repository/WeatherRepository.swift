//
//  WeatherRepository.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 19/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import Combine

class WeatherRepository {
    
    private var cancellable: AnyCancellable?
    
    func fetchWeather(latitude: Double, longitude: Double, language: String, completion: @escaping (JSONObject) -> ()) {
        let url = URL(string:  "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(language)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric")!
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map {
                print(String(data:$0, encoding: .utf8))
                return $0
            }
            .decode(type: JSONObject.self, decoder: JSONDecoder())
            .print()
            //.replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    print("Finisched")
                    
                case .failure(let error):
                    print("Failure: \(error)")
        
                }
                
            }, receiveValue: { weathersResult in
                
                print("RISULTATO\(weathersResult)")
                completion(weathersResult)
                //self.weathers = weathersResult
                
            })
    }
    
}

//extension WeatherRepository {
    struct JSONObject: Codable {
        let cod: String
        let message: Int
        let cnt: Int
        let list: [List]
        let city: City
    }

    struct List: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Float
        let sys: Sys
        let txt: String
        
    //            init(from decoder: Decoder) throws {
    //                let container = try decoder.container(keyedBy: CodingKeys.self)
    //
    //                self.dt = try container.decode(Int.self, forKey: .dt)
    //                self.main = try container.decode(Main.self, forKey: .main)
    //                self.weather = try container.decode([Weather].self, forKey: .weather)
    //                self.clouds = try container.decode(Clouds.self, forKey: .clouds)
    //                self.wind = try container.decode(Wind.self, forKey: .wind)
    //                self.visibility = try container.decode(Int.self, forKey: .visibility)
    //                self.pop = (try? container.decodeIfPresent(Float.self, forKey: .pop)) ?? 42
    //                self.sys = (try? container.decodeIfPresent(Sys.self, forKey: .sys)) ?? Sys(pod: "prova")
    //                self.txt = (try? container.decodeIfPresent(String.self, forKey: .txt)) ?? "ciao"
    //            }
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case main
            case weather
            case clouds
            case wind
            case visibility
            case pop
            case sys
            case txt = "dt_txt"
        }
    }

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int
        let grnd_level: Int
        let humidity: Int
        let temp_kf: Double
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Clouds: Codable {
        let all: Int
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }

    struct Sys: Codable {
        let pod: String
    }

    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population: Int
        let timezone: Double
        let sunrise: Double
        let sunset: Double
    }

    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }

//}
