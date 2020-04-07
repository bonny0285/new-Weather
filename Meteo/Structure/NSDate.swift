//
//  NSDate.swift
//  Meteo
//
//  Created by Massimiliano on 07/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import Foundation


extension NSDate {
    
//MARK: - AsString
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self as Date)
    }
}
