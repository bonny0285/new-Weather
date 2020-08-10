//
//  PreferredWeatherViewController.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class PreferredWeatherViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties

    
    var cell: [WeatherModelCell] = []
    
    var realmManager = RealmManager()
    
    var dataSource: PreferredDataSource?
    var weathers: [RealmWeatherManager] = []
    
    var fetchManager = FetchWeather()
    var arrayName: [String] = []
    
    var arrayConditon: [FetchWeather.WeatherCondition] = []
    var arrayImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        tableView.delegate = self
        weathers = realmManager.retriveWeather()
        print("RETRIVE",weathers.count)
        
        for (index, weather) in weathers.enumerated() {
            
            fetchManager.getMyWeatherData(forLatitude: weather.latitude, forLongitude: weather.longitude) { weatherFetch in
                
                if index == 0 {
                    let cell = weatherFetch.weatherForCell
                    self.cell = cell
                }
                
                self.arrayName.append(weatherFetch.name)
                self.arrayConditon.append(self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weatherFetch.conditionID))
                self.arrayImages.append(UIImage(named: self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weatherFetch.conditionID).rawValue)!)
                
                self.tableView.reloadData()
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        

        
        
        self.dataSource = PreferredDataSource(arrayName: self.arrayName, arrayForCell: self.cell, arrayConditon: self.arrayConditon, arrayImages: self.arrayImages)
        
        self.tableView.dataSource = self.dataSource
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
        
    }
    



}


extension PreferredWeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
