//
//  PreferredDataSource.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class PreferredDataSource: NSObject {
    

    
    let organizer: DataOrganizer
    let weatherManager: [WeatherGeneralManager]
    
    init(weatherManager: [WeatherGeneralManager]) {
        self.weatherManager = weatherManager
        self.organizer = DataOrganizer(weatherManager: weatherManager)
    }
    
    func itemsCount() -> Int {
        weatherManager.count
    }
    
    func imageNavigationBar() -> UIImage? {
        UIImage(named: (weatherManager.first?.condition.getWeatherConditionFromID(weatherID: weatherManager.first!.conditionID).rawValue)!)!
    }

    func conditionForNavigationBar() -> WeatherGeneralManager.WeatherCondition? {
        weatherManager.first?.condition ?? nil
    }
}


extension PreferredDataSource {
    
    struct DataOrganizer {
        
        var counter: Int {
            weatherManager.count
        }
        
        let weatherManager: [WeatherGeneralManager]
        
        init(weatherManager: [WeatherGeneralManager]) {
            self.weatherManager = weatherManager

        }

        func locationName(_ index: IndexPath) -> String {
            weatherManager[index.row].name
        }
        
        func weatherCell(_ index: IndexPath) -> WeatherGeneralManagerCell {
            weatherManager[index.row].weathersCell[index.row]
        }
        
        func condition(_ index: IndexPath) -> WeatherGeneralManager.WeatherCondition {
            weatherManager[index.row].condition
        }
        
        func image(_ index: IndexPath) -> UIImage {
            UIImage(named: weatherManager[index.row].condition.getWeatherConditionFromID(weatherID: weatherManager[index.row].conditionID).rawValue)!
        }
        
        func gradi(_ index: IndexPath) -> String {
            weatherManager[index.row].temperatureString
        }
         
    }
        
}


extension PreferredDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        organizer.counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredTableViewCell", for: indexPath) as? PreferredTableViewCell else { return UITableViewCell()}
        
        let name = organizer.locationName(indexPath)
        let weatherCell = organizer.weatherCell(indexPath)
        let condition = organizer.condition(indexPath)
        let image = organizer.image(indexPath)
        let gradi = organizer.gradi(indexPath)
        
        cell.configure(name, weatherCell, condition, image, gradi)
        
        return cell
    }

}


extension PreferredTableViewCell {
    
    func configure(_ row: String,_ weather: WeatherGeneralManagerCell, _ condition: WeatherGeneralManager.WeatherCondition, _ background: UIImage,_ gradi: String) {
        
        self.name.text = row
        
        self.weatherImage.image = UIImage(named: weather.setCellImageAtCondition)
//        if #available(iOS 13.0, *) {
//            self.weatherImage.image = UIImage(systemName: weather.conditionName)
//        } else {
//            self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
//        }
        
        self.degreesLabel.text = gradi
        
        self.backgroundImage.image = background
        setColorUIViewForBackground(condition)
    }
    
    
    //MARK: - SetColorUIViewForBackground
    func setColorUIViewForBackground(_ condition: WeatherGeneralManager.WeatherCondition) {
        
        switch condition {
        case .tempesta:
            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            name.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .pioggia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .pioggiaLeggera:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .neve:
            weatherImage.tintColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            name.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        case .nebbia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .sole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .nuvole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    }
}
