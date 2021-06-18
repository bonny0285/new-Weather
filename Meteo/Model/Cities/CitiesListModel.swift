//
//  CitiesListModel.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

//@objcMembers

/// CityBulk class is used for decoding "cityList.json"
class CityBulk: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var coord: CoordBulk? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func == (lhs: CityBulk, rhs: CityBulk) -> Bool {
        return lhs.name == rhs.name
    }
}

/// CoordBulk is used for instantiate an attribute in CityBulk class
class CoordBulk: Object, Codable {
    @objc var lat: Double = 0.0
    @objc var lon: Double = 0.0
}

/// CitybulkDictionary is used for storage data usign Realm
class CityBulkDictionary: Object, Codable {
    @objc dynamic var index: String = ""
    dynamic var cities = List<CityBulk>()
    
    override init() { super.init() }

    init(index: String, cities: List<CityBulk>) {
        self.index = index
        self.cities = cities
    }
}
