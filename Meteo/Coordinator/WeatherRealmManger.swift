//
//  WeatherRealmManger.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 20/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


protocol WeatherRealmManagerDelegate: class {
    func setupNavigationBar(_ count: Int, _ favoriteButton: Bool, _ addButton: Bool)
    func weathersDidFetched(_ weathers: [MainWeather]?)
}



class WeatherRealmManger {
    
    var status: ResultStatus? {
        didSet {
            switch status {
            case .zero(let count):
                zero(count)
            case .oneToNine(let count, let result):
                oneToNine(count, result)
            case .ten(let count, let result):
                ten(count, result)
            default:
                break
            }
        }
    }
    
    var delegate: WeatherRealmManagerDelegate?
    
    init() {}
    
    func retriveData() {
        
        do {
            let realm = try Realm.init()
            let result = realm.objects(RealmWeatherManager.self)
            
            switch result.count {
            case 0:
                status = .zero(count: result.count)
            case 1 ... 9:
                status = .oneToNine(count: result.count, result: result)
            case 10:
                status = .ten(count: result.count, result: result)
            default:
                break
            }
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    
    private func zero(_ count: Int) {
        delegate?.setupNavigationBar(count, false, true)
        delegate?.weathersDidFetched(nil)
    }
    
    private func oneToNine(_ count: Int, _ result: Results<RealmWeatherManager>) {
        delegate?.setupNavigationBar(count, true, true)
        let fetchingFavoriteWeathers = FetchingFavoriteWeathers(result: result)
        fetchingFavoriteWeathers.delegate = self
    }
    
    private func ten(_ count: Int, _ result: Results<RealmWeatherManager>) {
        delegate?.setupNavigationBar(count, true, false)
        let fetchingFavoriteWeathers = FetchingFavoriteWeathers(result: result)
        fetchingFavoriteWeathers.delegate = self
    }
    

}

extension WeatherRealmManger {
    enum ResultStatus {
        case zero(count: Int)
        case oneToNine(count: Int, result: Results<RealmWeatherManager>)
        case ten(count: Int, result: Results<RealmWeatherManager>)
    }
}


extension WeatherRealmManger: FetchingFavoriteWeatherDelegate {
    func getError(_ error: String, _ isError: Bool) {
        #warning("Gestione Errore")
    }
    
    func getWeathers(_ weathers: [MainWeather]) {
        delegate?.weathersDidFetched(weathers)
    }
}
