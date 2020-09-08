//
//  AllCitiesList.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class AllCitiesList {
    var cities: [CitiesList]?
    
    init() {
        self.fetchCitiesFromJONS()
    }
    
    
    
    func fetchCitiesFromJONS () {
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            
            cities = result.sorted { $0.name < $1.name}.compactMap { $0 }
            debugPrint("Fetched JSON Cities Bulk")
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }

}
