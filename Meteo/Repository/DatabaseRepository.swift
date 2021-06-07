//
//  DatabaseRepository.swift
//  Meteo
//
//  Created by Massimiliano on 01/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class Dict: Object {
    @objc dynamic var index: String = ""
//    @objc dynamic var cities = List<CitiesListRealm>
    let cities = RealmSwift.List<CitiesListRealm>()
}

class DatabaseRepository {
    
    
    func saveee(_ citiesList: [CitiesListRealm]) {
        
        do {
            let realm = try Realm.init()
            try realm.write {
                
            }
        } catch {
            print("Error during save all city list: \(error)")
        }
    }
    
    func saveToDict(_ citiesList: [CitiesListRealm]) {
        do {
            
            let dict: [String : CitiesListRealm] = [:]
            let realm = try Realm.init()
            try realm.write {
                let filtered = citiesList.filter {
                    $0.name.isEmpty == false
                        && $0.name.starts(with: "-") == false
                        && $0.name.starts(with: "(") == false
                        && $0.name.starts(with: "'") == false
                }
                
                let dict = Dictionary(grouping: filtered, by: { String($0.name.first!) })
                var dictionaryContainer: [Dict] = []
                
                for (key, value) in dict {
                    dictionaryContainer.append(Dict(value: [key, value]))
                }
                print("Stai salvando: \(dictionaryContainer.count) elementi.")
                realm.add(dictionaryContainer)
            }
        } catch {
            
        }
    }
    
    func retriveAllDict(completion: @escaping (Results<Dict>?) -> ()) {
        
        do {
            let realm = try Realm.init()
            let results = realm.objects(Dict.self)
            completion(results)
        } catch {
            completion(nil)
        }
    }
    
    func retriveAllDictByLetter(_ letter: String, completion: @escaping (Results<Dict>?) -> ()) {
        do {
            let realm = try Realm.init()
            let results = realm.objects(Dict.self)
            //let filtered = results.filter { $0.index == letter }
            let compairingText = letter.uppercased()
            //let filtered = results.filter("index BEGINSWITH 'compairingText'")
            let filtered = results.filter("index BEGINSWITH '\(compairingText)'")
            completion(filtered)
        } catch {
            completion(nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    func save(_ citiesList: [CitiesListRealm]) {
        do {
            let realm = try Realm.init()
            try realm.write {
                realm.add(citiesList)
            }
        } catch {
            
        }
    }
    
    func retriveAll(completion: @escaping ([CitiesListRealm]?) -> ()) {
        
        do {
            let realm = try Realm.init()
            let results = realm.objects(CitiesListRealm.self).sorted { $0.name < $1.name }
            completion(results)
        } catch {
            completion(nil)
        }
    }
    
    func retriveByLetter(_ letter: String, completion: @escaping ([CitiesListRealm]?) -> ()) {
        do {
            let realm = try Realm.init()
            let results = realm.objects(CitiesListRealm.self).sorted { $0.name < $1.name }.filter { $0.name.starts(with: letter) }
            completion(results)
        } catch {
            completion(nil)
        }
    }
}
