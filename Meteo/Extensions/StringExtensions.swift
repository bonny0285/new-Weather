//
//  StringExtensions.swift
//  Meteo
//
//  Created by Massimiliano on 24/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

extension String {
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var temperatureString: String {
        String(format: "%.1f", self)
    }
    
    var stringDateString: String {
       let dateFormatter1 = DateFormatter()
       dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
       let dateFromString = dateFormatter1.date(from: self)
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "HH:mm E, d MMM y"
       //dateFormatter.dateFormat = "dd'/'MM'/'yyyy' 'HH':'mm':'ss"
       let date = dateFormatter.string(from: dateFromString!)
       return date
   }
    
    var uppercasedFirst: String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}


import SPMNetworkRepository


func prova () {
    let url = URL(string:  "http://api.openweathermap.org/data/2.5/forecast?lat=\(0.00)&lon=\(0.00)&lang=\("it")&APPID=b40d5e51a29e2610c4746682f85099b2&units=metric")!
    let a = NetworkRepository(url: url)
   
   
    a.fetch { (result: Result<JSONObject,Error>) in
        switch result {
        case .success( let value):
            print(value)
        case .failure(let error):
            print(error)
        }
    }
}
