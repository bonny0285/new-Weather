//
//  MainTableViewCell.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 17/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sfondo: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTime: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherTempMax: UILabel!
    @IBOutlet weak var weatherTempMin: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    fileprivate func commonInit() {
        self.addSubview(sfondo)
        sfondo.backgroundColor = .clear
        sfondo.frame = self.bounds
        sfondo.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sfondo.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sfondo.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sfondo.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive =  true
    }
    
    
    //MARK: - SetupCell
    
    func configureCell(_ weather: MainWeather,atIndexPath indexPath: IndexPath ,_ condition: MainWeather.WeatherCondition) {
        
        var temperatureMaxString: String {
            String(format: "%.1f", weather.weathersCell[indexPath.row].temperatureMax)
        }
        
        var temperatureMinString: String {
            String(format: "%.1f", weather.weathersCell[indexPath.row].temperatureMin)
        }
        
        weatherTempMax.text = temperatureMaxString
        weatherTempMin.text = temperatureMinString
        
        weatherDescription.text = "\(weather.weathersCell[indexPath.row].description.capitalized)"
        weatherTime.text = "\(stringDateString(forString: weather.weathersCell[indexPath.row].time))"
        
        weatherImage.image = UIImage(named: weather.weathersCell[indexPath.row].setCellImageAtCondition)
        
        setColorUIViewForBackground(condition)
    }
    
    //MARK: - StringDateString
    
     func stringDateString(forString string: String) -> String{
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter1.date(from: string)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        //dateFormatter.dateFormat = "dd'/'MM'/'yyyy' 'HH':'mm':'ss"
        let date = dateFormatter.string(from: dateFromString!)
        return date
    }
    
    
    //MARK: - SetColorUIViewForBackground
    
     func setColorUIViewForBackground(_ condition: MainWeather.WeatherCondition){
        
        switch condition {
        case .tempesta:
            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTime.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTempMax.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTempMin.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case .pioggia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .pioggiaLeggera:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .neve:
            weatherImage.tintColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        case .nebbia:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .sole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .nuvole:
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMax.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTempMin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    }
}
