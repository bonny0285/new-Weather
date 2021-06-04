//
//  SearchForCityViewModel.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 25/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import Combine

class SearchForCityViewModel: NSObject {
    
    @Published var cities: [CitiesList]?
    
    override init() {
        super.init()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.fetchCities { [weak self] result in
//                guard let self = self else { return }
//                
//                switch result {
//                case .success(let value):
//                    self.cities = value
//                    
//                case .failure(let error):
//                    print("Error during fetch cities: \(error.localizedDescription)")
//                }
//            }
//       }
    }
    
    func fetchBySearch(startWith text: String, completion: @escaping ([CitiesList]?) -> ()) {
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data).filter { $0.name.starts(with: text) }
            let cities = result.sorted { $0.name < $1.name}.compactMap { $0 }
            completion(cities)
            
        } catch let error {
            print(error)
            completion(nil)
        }
    }
//    
//    private func fetchCities(_ completion: @escaping(Result<[CitiesList], Error>) -> ()) {
//        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
//        
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
//            let decoder = JSONDecoder()
//            let result = try decoder.decode([CitiesList].self, from: data)
//            
//            let cities = result.sorted { $0.name < $1.name}.compactMap { $0 }
//            completion(.success(cities))
//            
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
}
