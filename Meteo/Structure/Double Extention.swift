//
//  Double Extention.swift
//  Meteo
//
//  Created by Massimiliano on 07/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import Foundation


extension Double {
    
    
//MARK: - TwoDecimalNumbers
    func twoDecimalNumbers(place: Int) -> Double{
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
    }
}


