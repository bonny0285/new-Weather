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

    var realmManager = RealmManager()
    
    var dataSource: PreferredDataSource?
    var weathers: [RealmWeatherManager] = []
    
    var fetchManager = FetchWeather()
    var arrayName: [String] = []
    var arrayForCell: [[WeatherCell]] = []
    var arrayConditon: [FetchWeather.WeatherCondition] = []
    var arrayImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        tableView.delegate = self
        weathers = realmManager.retriveWeather()
        print("RETRIVE",weathers.count)
        
        weathers.forEach {
            fetchManager.getMyWeatherData(forLatitude: $0.latitude, forLongitude: $0.longitude) { (weather, weatherCell) in
                self.arrayName.append(weather.nome)
                self.arrayForCell.append(weatherCell)
                self.arrayConditon.append(self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionId))
                self.arrayImages.append(UIImage(named: self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionId).rawValue)!)
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        

        
        
        self.dataSource = PreferredDataSource(arrayName: self.arrayName, arrayForCell: self.arrayForCell, arrayConditon: self.arrayConditon, arrayImages: self.arrayImages)
        
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
