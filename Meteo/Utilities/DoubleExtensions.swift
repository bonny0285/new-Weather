//
//  DoubleExtensions.swift
//  Meteo
//
//  Created by Massimiliano on 24/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

extension Double {
    func transformTimestampToString() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        //formatter.timeStyle = .short
        let string = formatter.string(from: date as Date)
        return string
    }
    
    var temperatureString: String {
        String(format: "%.1f", self)
    }
}
