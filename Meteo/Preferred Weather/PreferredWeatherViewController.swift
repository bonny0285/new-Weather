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
    var fetchWeatherManager = FetchWeatherManager()
    var cellAtIndexPath: Int = 0
    var dataSource: PreferredDataSource?
    var realmManager = RealmManager()
    var weatherManager: WeatherManagerModel? {
        didSet {
           dataSource = PreferredDataSource(weatherManager: weatherManager!)
        }
    }

    
    var loadingController = UIViewController() {
        didSet {
            loadingController = UIStoryboard(name: "loading", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        title = NSLocalizedString("preferred_title", comment: "")
        
        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        tableView.reloadData()
//    }
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    
    func refreschDataBaseAfterDelete() {
        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        let loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        weatherManager?.deleteAll()
        
        present(loadingController, animated: true) {
            let relamManager = RealmManager()
            relamManager.delegate = self
            relamManager.retriveWeather()
            self.tableView.reloadData()
           
            loadingController.dismiss(animated: true, completion: nil)
        }
      
                       
                   

    }
}


extension PreferredWeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    

    
    private func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let configuration = UISwipeActionsConfiguration(actions: [self.removePreferredWeather(forRowAt: indexPath)])
            configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    func removePreferredWeather(forRowAt indexPath: IndexPath)-> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction: UIContextualAction, view : UIView,completion: (Bool) -> Void) in
            contextualAction.image = UIImage(named: "i_Elimina")
            self.realmManager.deleteWeather(indexPath) {
                self.refreschDataBaseAfterDelete()
                print("DELETED")
            }
            self.tableView.reloadData()
        }

        action.backgroundColor = #colorLiteral(red: 1, green: 0.6682497973, blue: 0.339296782, alpha: 1)

        return action
    }





}


extension PreferredWeatherViewController: RealmManagerDelegate {
    func retriveResultsDidFinished(_ weather: WeatherModel) {
        
        self.cell.append(weather.weatherForCell)
        self.weatherManager?.arrayGradi.append(weather.temperatureString)
        self.weatherManager?.arrayName.append(weather.name)
        self.weatherManager?.arrayConditon.append(weather.condition)
        self.weatherManager?.arrayImages.append(UIImage(named:self.fetchWeatherManager.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
        self.weatherManager?.arrayForCell = cell.first!
    }
}




