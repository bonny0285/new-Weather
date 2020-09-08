//
//  WeatherDataSource.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class WeatherDataSource: NSObject {
    
    
    let weathers: [WeatherGeneralManagerCell]
    let condition: WeatherGeneralManager.WeatherCondition
    let organizer: DataOrganizer
    
    init(weathers: [WeatherGeneralManagerCell], condition: WeatherGeneralManager.WeatherCondition) {
        self.weathers = weathers
        self.condition = condition
        self.organizer = DataOrganizer(weathers: weathers, condition: condition)
    }
}



extension WeatherDataSource {
    
    struct DataOrganizer {
        
        let weathers: [WeatherGeneralManagerCell]
        let condition: WeatherGeneralManager.WeatherCondition
        
        var weatherCount: Int {
            weathers.count
        }
        
        init(weathers: [WeatherGeneralManagerCell], condition: WeatherGeneralManager.WeatherCondition) {
            self.weathers = weathers
            self.condition = condition
        }
        
        func weather(at indexPath: IndexPath) -> WeatherGeneralManagerCell{
            self.weathers[indexPath.row]
        }
        
    }
}


extension WeatherDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        organizer.weatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        
        let item = organizer.weather(at: indexPath)
        cell.configureWith(at: item, for: organizer.condition)
        
        return cell
    }
    
    
}


extension MainTableViewCell {
    func configureWith(at weather: WeatherGeneralManagerCell, for condition: WeatherGeneralManager.WeatherCondition) {
        
        var temperatureMaxString: String {
            String(format: "%.1f", weather.temperatureMax)
        }
        
        var temperatureMinString: String {
            String(format: "%.1f", weather.temperatureMin)
        }
        
        weatherTempMax.text = temperatureMaxString
        weatherTempMin.text = temperatureMinString
        
        weatherDescription.text = "\(weather.description.capitalized)"
        weatherTime.text = "\(stringDateString(forString: weather.time))"
        
        weatherImage.image = UIImage(named: weather.setCellImageAtCondition)
        
        setColorUIViewForBackground(condition)
    }
}
