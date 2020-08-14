//
//  WeatherTableViewCell.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

//MARK: - WeatherTableViewCell
class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTime: UILabel!
    @IBOutlet weak var temperatureMax: UILabel!
    @IBOutlet weak var temperatureMin: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    
    //MARK: - SetupCell
    
    func configureCell(_ weather: WeatherGeneralManager,atIndexPath indexPath: IndexPath ,_ condition: WeatherGeneralManager.WeatherCondition) {
        temperatureMax.text = "Temp Max: \(weather.weathersCell[indexPath.row].temperatureMax)"
        temperatureMin.text = "Temp Min: \(weather.weathersCell[indexPath.row].temperatureMin)"
        weatherDescription.text = "\(weather.weathersCell[indexPath.row].description.capitalized)"
        weatherTime.text = "\(stringDateString(forString: weather.weathersCell[indexPath.row].time))"
        
        if #available(iOS 13.0, *) {
            self.weatherImage.image = UIImage(systemName: weather.weathersCell[indexPath.row].conditionName)
        } else {
            self.weatherImage.image = UIImage(named: weather.weathersCell[indexPath.row].conditionNameOldVersion)
        }
        
        setColorUIViewForBackground(condition)
    }
    
    
    //MARK: - StringDateString
    func stringDateString(forString string: String) -> String{
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter1.date(from: string)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'/'MM'/'yyyy' 'HH':'mm':'ss"
        let date = dateFormatter.string(from: dateFromString!)
        return date
    }
    
    
    
    
    //MARK: - SetColorUIViewForBackground
    
    func setColorUIViewForBackground(_ condition: WeatherGeneralManager.WeatherCondition){
        
        switch condition {
        case .tempesta:
            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            temperatureMax.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            temperatureMin.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .pioggia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .pioggiaLeggera:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .neve:
            weatherImage.tintColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        case .nebbia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .sole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .nuvole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    }
    
    
}
