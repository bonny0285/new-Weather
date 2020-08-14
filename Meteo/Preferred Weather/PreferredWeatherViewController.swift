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

    
    
    var cell: [[WeatherGeneralManagerCell]] = []
    var cellAtIndexPath: Int = 0
    var dataSource: PreferredDataSource?
    var realmManager = RealmManager()
    var weatherManager: WeatherManagerModel? {
        didSet {
           dataSource = PreferredDataSource(weatherManager: weatherManager!)
        }
    }

    
    var loadingController = UIViewController()
    
    
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

    func runLoadingController(completion: @escaping () -> ()) {
        navigationController?.pushViewController(loadingController, animated: true)
        completion()
    }
    
    func refreschDataBaseAfterDelete() {
        
        weatherManager?.deleteAll()
        
        runLoadingController {
            let relamManager = RealmManager()
            relamManager.retriveWeatherForFetchManager {
                relamManager.delegation = self
            }

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

        action.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)

        return action
    }





}


extension PreferredWeatherViewController: RealmWeatherManagerDelegate {
    func retriveResultsDidFinished(_ weather: WeatherGeneralManager) {
        self.cell.append(weather.weathersCell)
        self.weatherManager?.arrayGradi.append(weather.temperatureString)
        self.weatherManager?.arrayName.append(weather.name)
        self.weatherManager?.arrayConditon.append(weather.condition)
        self.weatherManager?.arrayImages.append(UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
        self.weatherManager?.arrayForCell = cell.first!
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
                self.tableView.reloadData()
            
        }
    }

}




