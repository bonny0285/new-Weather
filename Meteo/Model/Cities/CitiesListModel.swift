//
//  CitiesListModel.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

//@objcMembers
class CitiesListRealm: Object, Decodable {
    @objc dynamic var reference = UUID().uuidString
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "reference"
      }
    
    init(reference: String,id: Int, name: String, country: String, latitude: Double, longitude: Double) {
        self.reference = reference
        self.id = id
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}


class CitiesList: Decodable, Hashable {
    let reference = UUID().uuidString
    let id: Int
    let name: String
    let country: String
    let coord: CityCoord
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reference)
    }

    static func == (lhs: CitiesList, rhs: CitiesList) -> Bool {
        return lhs.reference == rhs.reference
    }
}



struct CityCoord: Decodable {
    let lat: Double
    let lon: Double
}
