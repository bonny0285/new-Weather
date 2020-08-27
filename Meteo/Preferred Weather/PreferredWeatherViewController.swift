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
    
    #warning("cambiare il testo e metterlo in inglese")
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressSave: UIProgressView! {
        didSet {
            setCurrentProgress(weatherManager.arrayName.count)
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet {
            backgroundImage.image = dataSource?.imageNavigationBar()

        }
    }
    
    
    //MARK: - Properties
    
    
    var progress = Progress(totalUnitCount: 10)
    var cell: [[WeatherGeneralManagerCell]] = []
    var dataSource: PreferredDataSource?
    var realmManager = RealmManager()
    
    var weatherManager = WeatherManagerModel() {
        didSet {
            dataSource = PreferredDataSource(weatherManager: weatherManager)
        }
    }
    
    var loadingController = UIViewController()
    
    var imageForNavigationBar: UIImage! {
        didSet {
            navigationController?.navigationBar.setBackgroundImage(dataSource?.imageNavigationBar(), for: .default)
            let condition = dataSource?.conditionForNavigationBar()
            switch condition {
            case .tempesta:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggiaLeggera:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .neve:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            default:
                break
           
            }
        }
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }

        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "new_back"), style: .plain, target: self, action: #selector(cancelTapped(_:)))
        navigationItem.leftBarButtonItem = leftButton
        
        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        dataSource = PreferredDataSource(weatherManager: weatherManager)
        tableView.dataSource = dataSource
        tableView.delegate = self
        let footerView = UIView()
        footerView.backgroundColor = .red
        tableView.tableFooterView = footerView
        imageForNavigationBar = dataSource?.imageNavigationBar()
        tableView.reloadData()
    }
    
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    //MARK: - Navighation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowToMain" {
            if let controller = segue.destination as? MainViewController {
                controller.navigationBarStatus = .noFavorite
                let indexPathToReload = IndexPath(row: 0, section: 0)
                controller.tableView.selectRow(at: indexPathToReload, animated: true, scrollPosition: .top)
                controller.imageForNavigationBar = controller.mainBackgroundImage.image
            }
        } else if segue.identifier == "BackToMain" {
            if let controller = segue.destination as? MainViewController {
                let item = sender as! Int
                if item < 10 {
                    controller.navigationBarStatus = .allPresent
                } else {
                    controller.navigationBarStatus = .noAdd
                }
                let indexPathToReload = IndexPath(row: 0, section: 0)
                controller.tableView.selectRow(at: indexPathToReload, animated: true, scrollPosition: .top)
                controller.imageForNavigationBar = controller.mainBackgroundImage.image
            }
        }
    }

    
    //MARK: - Actions


    @objc func cancelTapped(_ sender: UIBarButtonItem) {
        let items = dataSource?.itemsCount()
        performSegue(withIdentifier: "BackToMain", sender: items)
    }
    
    
    func setCurrentProgress(_ progressDone: Int) {
        progress.completedUnitCount = Int64(progressDone)
        let progressFloat = Float(progress.fractionCompleted)
        progressSave.setProgress(progressFloat, animated: true)
    }
    
}


//MARK: - UITableViewDelegate

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
        let action = UIContextualAction(style: .destructive, title: "") { (contextualAction: UIContextualAction, view : UIView,completion: (Bool) -> Void) in
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(self.loadingController, animated: true)
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.weatherManager.deleteAll()
            self.realmManager.deleteWeather(indexPath)
            self.realmManager.delegation = self
            self.realmManager.retriveWeatherForFetchManager()
            
            print("DELETED")
        }
        action.image = UIImage(named: "i_Elimina")
        action.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return action
    }
    
}


//MARK: - RealmWeatherManagerDelegate

extension PreferredWeatherViewController: RealmWeatherManagerDelegate {
    func retriveEmptyResult() {
        debugPrint("No Item Saved Into Database !!!")
        self.performSegue(withIdentifier: "ShowToMain", sender: nil)
    }
    
    func retriveResultsDidFinished(_ weather: WeatherGeneralManager) {
        
        self.cell.append(weather.weathersCell)
        self.weatherManager.arrayGradi.append(weather.temperatureString)
        self.weatherManager.arrayName.append(weather.name)
        
        self.weatherManager.arrayConditon.append(weather.condition)
        self.weatherManager.arrayImages.append(UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)!)
        self.weatherManager.arrayForCell = cell.first!
        
        DispatchQueue.main.async {
            self.setCurrentProgress(self.weatherManager.arrayName.count)
            self.navigationController?.popViewController(animated: true)
            self.tableView.reloadData()
            self.navigationController?.navigationBar.isHidden = false
            self.imageForNavigationBar = self.dataSource?.imageNavigationBar()
        }
    }
    
}




