//
//  IntExtensions.swift
//  Meteo
//
//  Created by Massimiliano on 24/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

extension Int {
    var weatherBackgroundImage: UIImage {
        switch self {
        case 200...202, 210...212, 221 ,230...232:
            return UIImage(named: "tempesta")!
            
        case 300...302, 310...314, 321:
            return UIImage(named: "pioggia_leggera")!
            
        case 500...504, 511, 520...522, 531:
            return UIImage(named: "pioggia")!
            
        case 600...602, 611...613, 615, 616, 620...622:
            return UIImage(named: "neve")!
            
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return UIImage(named: "nebbia")!
            
        case 800:
            return UIImage(named: "sole")!
            
        case 801...804:
            return UIImage(named: "nuvole")!
            
        default:
            return UIImage(named: "sole")!
        }
    }
    
    
    var weatherImage : UIImage? {
        switch self {
        case 200...202, 210...212, 221 ,230...232:
            return UIImage(named: "new_tempesta")
        case 300...302, 310...314, 321:
            return UIImage(named: "new_pioggia_leggera")
        case 500...504, 511, 520...522, 531:
            return UIImage(named: "new_pioggia")
        case 600...602, 611...613, 615, 616, 620...622:
            return UIImage(named: "new_neve")
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return UIImage(named: "new_nebbia")
        case 800:
            return UIImage(named: "new_sun")
        case 801 ... 804:
            return UIImage(named: "new_cloud")
        default:
            return UIImage(named: "cloud")
        }
    }
}
