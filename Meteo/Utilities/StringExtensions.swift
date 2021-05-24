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
}
