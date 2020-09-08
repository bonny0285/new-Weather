//
//  SavedWeather.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class SavedWeather {
    
    var realmManager: RealmManager?
    var savedWeather: [MainWeather]?
    
    init() {
        
        realmManager = RealmManager()
        self.savedWeather = realmManager?.weatherGeneralManager
    }
}
