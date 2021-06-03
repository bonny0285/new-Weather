//
//  DatabaseRepository.swift
//  Meteo
//
//  Created by Massimiliano on 01/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseRepository {
    
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
