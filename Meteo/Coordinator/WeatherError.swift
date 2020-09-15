//
//  WeatherError.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 15/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

protocol WeatherErrorDelegate: class {
    func genericError()
    func singleError()
    func multipleError()
}


class WeatherError: NSObject {
    
    weak var delegate: WeatherErrorDelegate?
    
    var errorState: ErrorState = .genericError {
        didSet {
            switch errorState {
            case .genericError:
                self.delegate?.genericError()
            case .singleWeatherError:
                self.delegate?.singleError()
            case .multipleWeatherError:
                self.delegate?.multipleError()
            }
        }
    }
    
}



extension WeatherError {
    enum ErrorState {
        case genericError
        case singleWeatherError
        case multipleWeatherError
    }
}
