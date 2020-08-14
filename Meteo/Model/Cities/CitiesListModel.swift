//
//  CitiesListModel.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


struct CitiesList: Decodable {
    let id: Int
    let name: String
    let country: String
    let coord: Coord
}



struct Coord: Decodable {
    let lat: Double
    let lon: Double
}
