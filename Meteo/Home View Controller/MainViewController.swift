//
//  MainViewController.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation



protocol MainViewControllerLocationDelegate: class {
    func locationDidChange(_ response: CitiesList)
}


class MainViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundView?.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var mainBackgroundImage: UIImageView! {
        didSet {
            if case .neve = weatherCondition {
                mainBackgroundImage.alpha = 0.8
            }
        }
    }
    
    //MARK: - Properties
    
    typealias LocationForUser = (latitude: Double,longitude: Double)
    
    let locationManager = CLLocationManager()
    
    var language: String = ""
    
    var delegate: MainViewControllerLocationDelegate?
    
    var citiesList: [CitiesList] = []
    
    var coordinateUserLocation: LocationForUser = (0.0, 0.0)
    
    var currentLocation: LocationForUser = (0.0, 0.0)
    
    var imageForNavigationBar: UIImage! {
        didSet {
            navigationController?.navigationBar.setBackgroundImage(mainBackgroundImage.image, for: .default)
            let condition = weatherCondition
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
            }
        }
    }
    
    var navigationBarStatus: NavigationBarStatus = .allPresent {
        didSet {
            navigationController?.navigationBar.isHidden = false
            let currentLocationButton = UIBarButtonItem(image: UIImage(named: "new_location"), style: .plain, target: self, action: #selector(currentLocationButtonBarWasPressed(_:)))
            let searchButton = UIBarButtonItem(image: UIImage(named: "new_search"), style: .plain, target: self, action: #selector(searchButtonBarWasPressed(_:)))
            let favoriteButton = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(favoriteButtonBarWasPressed(_:)))
            let addButton = UIBarButtonItem(image: UIImage(named: "new_add"), style: .plain, target: self, action: #selector(addButtonBarWasPressed(_:)))
            
            switch navigationBarStatus {
                
            case .allPresent:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noCurrentLocation:
                navigationItem.leftBarButtonItems = [favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noFavorite:
                navigationItem.leftBarButtonItems = [currentLocationButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noAdd:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton]
            case .noSearch:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [addButton]
            case .noOne:
                navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    var loadingController = UIViewController()
    
    var weatherCondition: WeatherGeneralManager.WeatherCondition = .nebbia {
        didSet {
            navigationController?.navigationBar.tintColor = .black
        }
    }
    
    var weatherGeneralManager: WeatherGeneralManager?
    var weatherFetchManager: WeatherFetchManager?
    var weatherGeneralManagerCell: [WeatherGeneralManagerCell] = []
    var favoriteWeatherManager: FavoriteWeatherManager?
    var realmManager = RealmManager()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //state = .loading
        navigationBarStatus = .noOne
        
        /// Instanzio il LoadingViewController
        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        navigationController?.pushViewController(loadingController, animated: true)
        
        /// Chiamate al LocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        /// Chimate alla TableView
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        language = Locale.current.languageCode!
        
        currentWeatherView.isHidden = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        delegate = self
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCitiesList" {
            if let controller = segue.destination as? CitiesListViewController {
                controller.citiesResult = sender as? [CitiesList]
                controller.citiesArray = citiesList
            }
        } else if segue.identifier == "ShowPreferredWeather" {
            if let controller = segue.destination as? PreferredWeatherViewController {
                controller.weatherManager = sender as! WeatherManagerModel
            }
        }
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}
    
    //MARK: - Actions & Functions
    
    
    //MARK: - Search Button Bar Action

    @objc func searchButtonBarWasPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowCitiesList", sender: citiesList)
    }
    
    //MARK: - Current Location Button Bar Action

    @objc func currentLocationButtonBarWasPressed(_ sender: UIBarButtonItem) {
        fetchResultAndSetupUI(coordinateUserLocation.latitude, coordinateUserLocation.longitude, true)
    }
    
    //MARK: - Add Button Bar Action

    @objc func addButtonBarWasPressed(_ sender: UIBarButtonItem) {

        self.realmManager.checkForLimitsCitySaved { [weak self] limit in
            guard let self = self else { return }
            self.navigationBarStatus = .noOne
            self.navigationController?.pushViewController(self.loadingController, animated: true)
            self.navigationController?.modalPresentationStyle = .fullScreen
            if limit == true {
                debugPrint("Limit Been Over")
                MyAlert.limitBeenOver(self)
                self.navigationController?.popViewController(animated: true)
                self.navigationBarStatus = .noAdd
                
            } else {
                self.realmManager.checkForAPresentLocation(city: self.currentWeatherView.locationName.text ?? "") { [weak self] present in
                    guard let self = self else { return }
                    
                    if present == true {
                        debugPrint("City already saved")
                        MyAlert.cityAlreadySaved(self) {
                            self.navigationController?.popViewController(animated: true)
                            self.navigationBarStatus = .allPresent
                        }
                    } else {
                        
                        self.realmManager.saveWeather(self.currentWeatherView.locationName.text ?? "", self.currentLocation.latitude, self.currentLocation.longitude)
                        self.favoriteWeatherManager = FavoriteWeatherManager()
                        self.realmManager.checkForLimitsCitySaved { [weak self] limit  in
                            guard let self = self else { return }
                            
                            if limit == true {
                                self.navigationBarStatus = .noAdd
                            } else {
                                self.navigationBarStatus = .allPresent
                            }
                        }
                    }
                }
            }
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    //MARK: - Favorite Button Bar Action

    @objc func favoriteButtonBarWasPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowPreferredWeather", sender: self.favoriteWeatherManager?.weather)
    }
    
    //MARK: - Fetch Weather JSON And Setup UI

    func fetchResultAndSetupUI(_ latitude: Double, _ longitude: Double,_ loadingControllerIsNeeded: Bool) {
        self.currentLocation.latitude = latitude
        self.currentLocation.longitude = longitude
        self.weatherGeneralManagerCell.removeAll()
        self.favoriteWeatherManager = FavoriteWeatherManager()
        
        if loadingControllerIsNeeded == true {
            self.navigationBarStatus = .noOne
            self.navigationController?.pushViewController(self.loadingController, animated: true)
            self.navigationController?.modalPresentationStyle = .fullScreen
        }
        
        self.weatherFetchManager = WeatherFetchManager(latitude: latitude, longitude: longitude, completion: { [weak self] weather in
            guard let self = self else { return }
            
            self.weatherGeneralManager = WeatherGeneralManager(name: weather.name, population: weather.population, country: weather.country, temperature: weather.temperature, conditionID: weather.conditionID,sunset: weather.sunset, sunrise: weather.sunrise, weathersCell: weather.weathersCell)
            
            DispatchQueue.main.async {
                self.fetchCitiesFromJONS()
                self.currentWeatherView.isHidden = false
                self.currentWeatherView.setupCurrentWeatherView(weather)
                self.currentWeatherView.setupColorViewAtCondition(weather.condition)
                self.currentWeatherView.setupCurrentWeatherView(weather)
                self.currentWeatherView.setupColorViewAtCondition(weather.condition)
                self.tableView.isHidden = false
                self.mainBackgroundImage.image = UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)
                self.weatherCondition = weather.condition
                self.imageForNavigationBar = self.mainBackgroundImage.image
                self.weatherGeneralManagerCell = weather.weathersCell
                
                if self.favoriteWeatherManager!.isLimitBeenOver == true {
                    self.navigationBarStatus = .noAdd
                } else {
                    self.navigationBarStatus = .allPresent
                }
                
                if self.favoriteWeatherManager?.isEmptyDataBase == true {
                    self.navigationBarStatus = .noFavorite
                }
                
                self.tableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    //MARK: - Fetch Cities List

    func fetchCitiesFromJONS () {
        citiesList.removeAll()
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            
            citiesList = result.sorted { $0.name < $1.name}.compactMap { $0 }
            debugPrint("Fetched JSON Cities Bulk")
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            coordinateUserLocation = (lat, lon)
            
            favoriteWeatherManager = FavoriteWeatherManager()
            
            fetchResultAndSetupUI(location.coordinate.latitude, location.coordinate.longitude, false)

        }
        
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
    
}



//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherGeneralManager?.weathersCell.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        
        cell.configureCell(weatherGeneralManager!, atIndexPath: indexPath, weatherGeneralManager!.condition)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}




//MARK: - MainViewControlloerLocationDelegate

extension MainViewController: MainViewControllerLocationDelegate {
    func locationDidChange(_ response: CitiesList) {
        
        fetchResultAndSetupUI(response.coord.lat, response.coord.lon, true)

    }
    
}


//MARK: - State

extension MainViewController {
    
    enum NavigationBarStatus{
        case allPresent
        case noCurrentLocation
        case noFavorite
        case noAdd
        case noSearch
        case noOne
    }
}


