//
//  WeatherTableViewCell.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTime: UILabel!
    @IBOutlet weak var temperatureMax: UILabel!
    @IBOutlet weak var temperatureMin: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    
    
    func setupCell(forWeather weather: WeatherCell,forBackground background: String){
        
        temperatureMax.text = "Temp Max: \(weather.temperatureMax)"
        temperatureMin.text = "Temp Min: \(weather.temperatureMin)"
        weatherDescription.text = "\(weather.weatherDescription.capitalized)"
        weatherTime.text = "\(stringDateString(forString: weather.weatherTime))"
        
            if #available(iOS 13.0, *) {
                print("iOS 13.0 Available")
                self.weatherImage.image = UIImage(systemName: weather.conditionName)
            } else {
                print("iOS 13.0 Not Available")
                self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
            }
        
        
        setColorUIViewForBackground(forCell: self, forBackground: background)
    }

    
    
    
    func stringDateString(forString string: String) -> String{
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter1.date(from: string)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'/'MM'/'yyyy' 'HH':'mm':'ss"
        let date = dateFormatter.string(from: dateFromString!)
        return date
    }

    
    
    
    
    func setColorUIViewForBackground(forCell cell : WeatherTableViewCell,forBackground backgroundImage: String){
            
            switch backgroundImage {
            case "tempesta":
                print("Tempesta")
                cell.weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.weatherTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.temperatureMax.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.temperatureMin.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.weatherDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case "pioggia":
                print("pioggia")
                cell.weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case "neve":
                print("Neve")
                cell.weatherImage.tintColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
                cell.weatherTime.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
                cell.temperatureMax.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
                cell.temperatureMin.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
                cell.weatherDescription.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            case "nebbia":
                print("Nebbia")
                cell.weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case "sole":
                print("Sole")
                cell.weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case "nuvole":
                print("Nuvole")
                cell.weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.temperatureMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            default:
                print("Default")
            }
        }

}
