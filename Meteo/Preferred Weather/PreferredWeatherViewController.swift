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

    
    var cell: [[WeatherModelCell]] = []
    var realmManager = RealmManager()
    var dataSource: PreferredDataSource?
    var weathers: [RealmWeatherManager] = []
    
    var fetchManager = FetchWeather()
    var arrayName: [String] = []
    
    var arrayCondition: [FetchWeather.WeatherCondition] = []
    var arrayImages: [UIImage] = []
    
    var loadingController = UIViewController() {
        didSet {
            loadingController = UIStoryboard(name: "loading", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        tableView.delegate = self
        tableView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.realmManager.delegate = self
        self.realmManager.retriveWeather()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }


}


extension PreferredWeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}


extension PreferredWeatherViewController: RealmManagerDelegate {
    
    func retriveResultsDidFinished(_ weather: WeatherModel) {
        
        self.cell.append(weather.weatherForCell)
        
        self.arrayName.append(weather.name)
        self.arrayCondition.append(self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID))
        self.arrayImages.append(UIImage(named: self.fetchManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
        
        DispatchQueue.main.async {
            
            self.dataSource = PreferredDataSource(arrayName: self.arrayName, arrayForCell: self.cell.first!, arrayConditon: self.arrayCondition, arrayImages: self.arrayImages)
            self.tableView.dataSource = self.dataSource
            self.tableView.isHidden = false
            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
        }
    }
}



