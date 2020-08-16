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
    
    @IBOutlet weak var mainCityNameLabel: UILabel! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                mainCityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                mainCityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                mainCityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                mainCityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                mainCityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                mainCityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                mainCityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var populationLabel: UILabel! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    @IBOutlet weak var mainWeatherImage: UIImageView! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                mainWeatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                mainWeatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                mainWeatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                mainWeatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                mainWeatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                mainWeatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                mainWeatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var mainWeatherTemperatureLabel: UILabel! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                mainWeatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var mainValuesContainer: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainBackgroundImage: UIImageView! {
        didSet {
            if case .neve = weatherCondition {
                mainBackgroundImage.alpha = 0.8
            }
        }
    }
    
    @IBOutlet weak var mainDegreesLabel: UILabel! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                mainDegreesLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggia:
                mainDegreesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                mainDegreesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                mainDegreesLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                mainDegreesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                mainDegreesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                mainDegreesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var mainCelsiusDegreesSymbol: UILabel! {
        didSet {
            switch weatherCondition {
            case .tempesta:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggia:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                mainCelsiusDegreesSymbol.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    
    //MARK: - Properties
    
    typealias LocationForUser = (latitude: Double,longitude: Double)
    
    //    var currentWeather: WeatherModel?
    //
    //    var weathersForCell: [WeatherModelCell] = []
    
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
    
    
    //var fetchWeatherManager: FetchWeatherManager?
    
    var navigationBarStatus: NavigationBarStatus = .allPresent {
        didSet {
            //navigationController?.navigationBar.barTintColor = .gray
            var locationImage = UIImage()
            var searchImage = UIImage()
            
            if #available(iOS 13.0, *) {
                locationImage = UIImage(systemName: "location.circle.fill")!
                searchImage = UIImage(systemName: "magnifyingglass")!
            } else {
                locationImage = UIImage(named: "address")!
                searchImage = UIImage(named: "search")!
            }
            
            let leftButton = UIBarButtonItem(image: locationImage, style: .plain, target: self, action: #selector(leftButtonWasPressed(_:)))
            let rightButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(rightButtonWasPressed(_:)))
            let preferredButtonItem = UIBarButtonItem(title: "Preferiti", style: .plain, target: self, action: #selector(preferedButtonItemPressed(_:)))
            let addButtonItem = UIBarButtonItem(title: "Aggiungi", style: .plain, target: self, action: #selector(addButtonItemWasPressed(_:)))
            
            switch navigationBarStatus {
                
            case .allPresent:
                navigationItem.leftBarButtonItems = [leftButton, preferredButtonItem]
                navigationItem.rightBarButtonItems = [rightButton, addButtonItem]
            case .noCurrentLocation:
                navigationItem.leftBarButtonItems = [preferredButtonItem]
                navigationItem.rightBarButtonItems = [rightButton, addButtonItem]
            case .noFavorite:
                navigationItem.leftBarButtonItems = [leftButton]
                navigationItem.rightBarButtonItems = [rightButton, addButtonItem]
            case .noAdd:
                navigationItem.leftBarButtonItems = [leftButton, preferredButtonItem]
                navigationItem.rightBarButtonItems = [rightButton]
            case .noSearch:
                navigationItem.leftBarButtonItems = [leftButton, preferredButtonItem]
                navigationItem.rightBarButtonItems = [addButtonItem]
            }
        }
    }
    
    var state: State = .notSave {
        didSet {
            switch state {
            case .save:
                print("SAVE")
            case .notSave:
                print("NOT SAVE")
            case .loading:
                if #available(iOS 13.0, *) {
                    overrideUserInterfaceStyle = .light
                }
                
                navigationController?.navigationBar.isHidden = true
            case .endLoading:
                navigationController?.navigationBar.isHidden = false
                
                if favoriteWeatherManager?.isEmptyDataBase == true {
                    navigationBarStatus = .noFavorite
                } else {
                    navigationBarStatus = .allPresent
                }
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
        
        state = .loading
        
        /// Instanzio il LoadingViewController
        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        navigationController?.pushViewController(loadingController, animated: true)
        
        /// Chiamate al LocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        /// Chimate alla TableView
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        language = Locale.current.languageCode!
        
        mainValuesContainer.isHidden = true
        
        //fetchCitiesFromJONS()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Chiamata al RealmManager per caricare i dati salvati
        //        weatherManager = WeatherManager(completion: {
        //            if weatherManager?.isEmptyDataBase == true {
        //
        //            }
        //        })
        state = .notSave
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
    
    
    @objc func rightButtonWasPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowCitiesList", sender: citiesList)
    }
    @objc func leftButtonWasPressed(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(loadingController, animated: true)
        navigationController?.navigationBar.isHidden = true
        prepareUIForWeather(coordinateUserLocation.latitude, coordinateUserLocation.longitude) {
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    @objc func addButtonItemWasPressed(_ sender: UIBarButtonItem) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(loadingController, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
        self.realmManager.saveWeather(self.mainCityNameLabel.text ?? "", self.currentLocation.latitude, self.currentLocation.longitude)
        self.favoriteWeatherManager = FavoriteWeatherManager()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigationController?.popViewController(animated: true)
            self.state = .endLoading
        })
    }
    
    @objc func preferedButtonItemPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowPreferredWeather", sender: self.favoriteWeatherManager?.weather)
    }
    
    
    func runLoadingController() {
        navigationController?.pushViewController(loadingController, animated: true)
    }
    
    
    func prepareUIForWeather(_ latitude: Double, _ longitude: Double, completion: @escaping () -> ()) {
        self.currentLocation.latitude = latitude
        self.currentLocation.longitude = longitude
        self.weatherFetchManager = WeatherFetchManager(latitude: latitude, longitude: longitude) { weather in
            self.setupUIForWeatherGeneralManager(weather: weather) {
                self.state = .endLoading
                completion()
            }
        }
    }
    
    func setupUIForWeatherGeneralManager(weather: WeatherGeneralManager, completion:@escaping () -> ()) {
        DispatchQueue.main.async {
            self.mainValuesContainer.isHidden = false
            self.tableView.isHidden = false
            self.mainCityNameLabel.text = weather.name
            let populationText = NSLocalizedString("population_label", comment: "")
            self.populationLabel.text = "\(populationText)\(weather.population)"
            self.mainWeatherTemperatureLabel.text = weather.temperatureString
            self.mainBackgroundImage.image = UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)
            self.weatherCondition = weather.condition
            self.imageForNavigationBar = self.mainBackgroundImage.image
            if #available(iOS 13.0, *) {
                self.mainWeatherImage.image = UIImage(systemName: weather.conditionName)
            } else {
                self.mainWeatherImage.image = UIImage(named: weather.conditionNameOldVersion)
            }
            
            self.weatherGeneralManagerCell = weather.weathersCell
            completion()
            
        }
    }
    
    func fetchCitiesFromJONS () {
        citiesList.removeAll()
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            
            citiesList = result.sorted { $0.name < $1.name}.compactMap { $0 }
            print("DONE")
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
                self.weatherFetchManager = WeatherFetchManager(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { weather in
                    self.currentLocation.latitude = location.coordinate.latitude
                    self.currentLocation.longitude = location.coordinate.longitude
                    self.weatherGeneralManager = WeatherGeneralManager(name: weather.name, population: weather.population, country: weather.country, temperature: weather.temperature, conditionID: weather.conditionID, weathersCell: weather.weathersCell)
                    DispatchQueue.main.async {
                        self.fetchCitiesFromJONS()
                            self.setupUIForWeatherGeneralManager(weather: self.weatherGeneralManager!) {
                                //self.citiesList = self.weatherGeneralManager!.citiesList
                                self.state = .endLoading
                                self.tableView.reloadData()
                                self.navigationController?.popViewController(animated: true)
                            }
                        
                        
                    }
                    
                })

            
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        
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
        self.prepareUIForWeather(response.coord.lat, response.coord.lon) {
            self.currentLocation.latitude = response.coord.lat
            self.currentLocation.longitude = response.coord.lon
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


//MARK: - State

extension MainViewController {
    
    enum State {
        case save
        case notSave
        case loading
        case endLoading
    }
    
    enum NavigationBarStatus{
        case allPresent
        case noCurrentLocation
        case noFavorite
        case noAdd
        case noSearch
        
    }
}


