//
//  ProgressPopupViewViewModel.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 17/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Combine

class ProgressPopupViewViewModel {
    
    @Published var counter: Int = 0
    var score: Int64 = 0
    
    func fetchCities(completion: @escaping (Result<[String : [CityBulk]], Error>) -> ()) {
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")!
                
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            //print(data.count)
            let result = try JSONDecoder().decode([CityBulk].self, from: data)
            let cities = result.filter { return $0.name != "" }
            let dict: [String : [CityBulk]] = Dictionary(grouping: cities, by: { String($0.name.first!) })
            completion(.success(dict))
            
        } catch let error {
            completion(.failure(error))
        }
    }

}
