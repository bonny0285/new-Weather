//
//  WeatherRepository.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 19/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import Combine
import SPMNetworkRepository

//class WeatherRepository {
//    
//    private var cancellable: AnyCancellable?
//    
//    func fetchWeather(latitude: Double, longitude: Double, language: String, completion: @escaping (JSONObject) -> ()) {
//        let url = URL(string:  "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(language)&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric")!
//        
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .map {
//                //print(String(data:$0, encoding: .utf8))
//                return $0
//            }
//            .decode(type: JSONObject.self, decoder: JSONDecoder())
//            .print()
//            //.replaceError(with: [])
//            .eraseToAnyPublisher()
//            .sink(receiveCompletion: { completion in
//                
//                switch completion {
//                case .finished:
//                    print("Finisched")
//                    
//                case .failure(let error):
//                    print("Failure: \(error)")
//        
//                }
//                
//            }, receiveValue: { weathersResult in
//                
//                print("RISULTATO\(weathersResult)")
//                completion(weathersResult)
//                //self.weathers = weathersResult
//                
//            })
//    }
//    
//    
//}



//}
