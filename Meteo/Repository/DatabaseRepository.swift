//
//  DatabaseRepository.swift
//  Meteo
//
//  Created by Massimiliano on 01/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift
//import Realm



class DatabaseRepository {

    func saveToDict(_ citiesList: [String : [CityBulk]]) {
        do {
            let mappedCities: [CityBulkDictionary] = citiesList.map { object -> CityBulkDictionary in
                let p = List<CityBulk>()
                for i in object.value {
                    p.append(i)
                }
                return CityBulkDictionary(index: object.key, cities: p)
            }
            let realm = try Realm.init()
            try realm.write {
                realm.add(mappedCities)
            }
        } catch {
            print("Error during save cities: \(error)")
        }
    }
    
//    func retriveAllDict(completion: @escaping ([Dict]?) -> ()) {
//        
//        do {
//            let realm = try Realm.init()
//            let results = realm.objects(Dict.self)
//            completion(results)
//        } catch {
//            completion(nil)
//        }
//    }
    
    func retriveAllDictByLetter(_ letter: String, completion: @escaping (List<CityBulk>?) -> ()) {
        do {
            let realm = try Realm.init()
            let results = realm.objects(CityBulkDictionary.self)
            //let filtered = results.filter { $0.index == letter }
            let compairingText = letter.uppercased()
            //let filtered = results.filter("index BEGINSWITH 'compairingText'")
            let filtered = results.filter("index BEGINSWITH '\(compairingText)'")
            let final: List<CityBulk> = filtered.first?.cities ?? List<CityBulk>()
            completion(final)
        } catch {
            completion(nil)
        }
    }

}
