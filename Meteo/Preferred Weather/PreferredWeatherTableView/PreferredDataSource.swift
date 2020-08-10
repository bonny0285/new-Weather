//
//  PreferredDataSource.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class PreferredDataSource: NSObject {
    
    
    var arrayName: [String]
    var arrayForCell: [[WeatherCell]]
    var arrayConditon: [FetchWeather.WeatherCondition]
    var arrayImages: [UIImage]
    
    let organizer: DataOrganizer
    
    init(arrayName: [String], arrayForCell: [[WeatherCell]], arrayConditon: [FetchWeather.WeatherCondition], arrayImages: [UIImage]) {
        self.arrayName = arrayName
        self.arrayForCell = arrayForCell
        self.arrayConditon = arrayConditon
        self.arrayImages = arrayImages
        
        self.organizer = DataOrganizer(arrayName: arrayName, arrayForCell: arrayForCell, arrayConditon: arrayConditon, arrayImages: arrayImages)
    }
    
    
    
}


extension PreferredDataSource {
    
    struct DataOrganizer {
        
        var arrayName: [String]
        var arrayForCell: [[WeatherCell]]
        var arrayConditon: [FetchWeather.WeatherCondition]
        var arrayImages: [UIImage]
        
        var counter: Int {
            arrayName.count
        }
        
        init(arrayName: [String], arrayForCell: [[WeatherCell]], arrayConditon: [FetchWeather.WeatherCondition], arrayImages: [UIImage]) {
            self.arrayName = arrayName
            self.arrayForCell = arrayForCell
            self.arrayConditon = arrayConditon
            self.arrayImages = arrayImages
        }
       

        func locationName(_ index: IndexPath) -> String {
            arrayName[index.row]
        }
        
        func weatherCell(_ index: IndexPath) -> WeatherCell {
            arrayForCell[index.row][0]
        }
        
        func condition(_ index: IndexPath) -> FetchWeather.WeatherCondition {
            arrayConditon[index.row]
        }
        
        func image(_ index: IndexPath) -> UIImage {
            arrayImages[index.row]
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
        
        cell.configure(name, weatherCell, condition, image)
        
        return cell
    }
}


extension PreferredTableViewCell {
    
    func configure(_ row: String,_ weather: WeatherCell, _ condition: FetchWeather.WeatherCondition, _ background: UIImage) {
        
        self.name.text = row
        
        
        if #available(iOS 13.0, *) {
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        } else {
            self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
        }
        
        self.backgroundImage.image = background
        setColorUIViewForBackground(condition)
    }
    
    
    //MARK: - SetColorUIViewForBackground
    func setColorUIViewForBackground(_ condition: FetchWeather.WeatherCondition) {
        
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
