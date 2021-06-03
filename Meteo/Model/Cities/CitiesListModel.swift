//
//  CitiesListModel.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class CitiesListRealm: Object {
    @objc dynamic var reference = UUID()
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var coord: CytiCoordRealm = CytiCoordRealm()
}

class CytiCoordRealm: Object {
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
}

struct CitiesList: Decodable, Hashable {
    let reference = UUID()
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
