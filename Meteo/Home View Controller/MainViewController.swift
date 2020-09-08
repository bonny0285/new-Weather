//
//  MainViewController.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation
import Lottie
import RealmSwift



protocol MainViewControllerLocationDelegate: class {
    func locationDidChange(_ response: CitiesList)
}


class MainViewController: UIViewController, Storyboarded {
    
    
    //MARK: - Outlets
    @IBOutlet weak var lottieContainer: UIView!
    
    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundView?.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var mainBackgroundImage: UIImageView! {
        didSet {
            mainBackgroundImage.image = UIImage(named: "_qEP_8Kt")
            if case .neve = weatherCondition {
                mainBackgroundImage.alpha = 0.8
            }
        }
    }
    
    //MARK: - Properties
    var coordinator: MainCoordinator?
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
                navigationItem.leftBarButtonItems = nil
                navigationItem.rightBarButtonItems = nil
            }
        }
    }
    
    var weatherCondition: MainWeather.WeatherCondition = .nebbia {
        didSet {
            navigationController?.navigationBar.tintColor = .black
        }
    }
    
    var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                navigationBarStatus = .noOne
                currentWeatherView.isHidden = false
                tableView.isHidden = true
                lottieContainer.isHidden = false
                mainBackgroundImage.isHidden = true
                let animation = Animation.named("loading")
                setupAnimation(for: animation!)
            case .presenting:
                currentWeatherView.isHidden = false
                tableView.isHidden = false
                lottieContainer.isHidden = true
                mainBackgroundImage.isHidden = false
                loadingView.stop()
            }
        }
    }
    
    var currentWeather: MainWeather?
    var dataSource: WeatherDataSource?
    private var loadingView = AnimationView()
    var weatherGeneralManagerCell: [WeatherGeneralManagerCell] = []
    let fetchManager = WeatherFetchManager()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .loading
        
        /// Chiamate al LocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        /// Chimate alla TableView
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        
        language = Locale.current.languageCode!
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if case .citiesListViewController = coordinator?.provenience {state = .loading
            guard let lat = coordinator?.city?.coord.lat, let lon = coordinator?.city?.coord.lon else { return }
            
            fetchManager.singleWeatherDelegate = self
            fetchManager.getMyWeatherData(forLatitude: lat, forLongitude: lon)}
        

        if case .mainViewController = coordinator?.provenience {
            setup(weather: (coordinator?.userLocation)!)
        }
        
        if case .preferedViewController = coordinator?.provenience {
            self.coordinator?.realmManager?.checkForLimitsCitySaved()
                       callerRealmForFetching()
                       setupNavigationBarButton()
        }
        
        self.imageForNavigationBar = self.mainBackgroundImage.image
        tableView.delegate = self
        tableView.reloadData()
    }
    
    //MARK: - Navigation
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}
    
    //MARK: - Actions & Functions
    
    func setupAnimation(for animation: Animation) {
        loadingView.frame = animation.bounds
        loadingView.animation = animation
        loadingView.contentMode = .scaleAspectFill
        lottieContainer.addSubview(loadingView)
        loadingView.backgroundBehavior = .pauseAndRestore
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: lottieContainer.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: lottieContainer.bottomAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: lottieContainer.trailingAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: lottieContainer.leadingAnchor).isActive = true
        self.loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    //MARK: - Search Button Bar Action
    
    @objc func searchButtonBarWasPressed(_ sender: UIBarButtonItem) {
        coordinator?.cameFromMainViewController = nil
        coordinator?.cityListViewController()
    }
    
    //MARK: - Current Location Button Bar Action
    
    @objc func currentLocationButtonBarWasPressed(_ sender: UIBarButtonItem) {
        self.state = .loading
        setup(weather: (coordinator?.userLocation)!)
        let index = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: index, animated: true, scrollPosition: .top)
    }
    
    //MARK: - Add Button Bar Action
    
    @objc func addButtonBarWasPressed(_ sender: UIBarButtonItem) {
        
        state = .loading
        
       if case .citiesListViewController = coordinator?.provenience {
            guard let name = currentWeather?.name, let lat = currentWeather?.latitude, let lon = currentWeather?.longitude else { return }
            
            self.coordinator?.realmManager?.delegate = self
            self.coordinator?.realmManager?.checkForAPresentLocation(city: name)
            self.coordinator?.realmManager?.checkForLimitsCitySaved()
            
            if self.coordinator?.isLimitOver == true {
                self.navigationBarStatus = .noAdd
                MyAlert.limitBeenOver(self)
                self.state = .presenting
            } else {
                if coordinator?.isPresentLocation == true {
                    MyAlert.cityAlreadySaved(self) { [weak self] in
                        guard let self = self else { return }
                        self.state = .presenting
                        self.navigationBarStatus = .allPresent
                    }
                } else {
                    self.coordinator?.realmManager?.saveWeather(name, lat, lon)
                    callerRealmForFetching()
                    setupNavigationBarButton()
                    state = .presenting
                }
            }
       } else {
        guard let name = coordinator?.userLocation?.name, let lat = coordinator?.userLocation?.latitude, let lon = coordinator?.userLocation?.longitude else { return }
                   
                   self.coordinator?.realmManager?.delegate = self
                   self.coordinator?.realmManager?.checkForAPresentLocation(city: name)
                   self.coordinator?.realmManager?.checkForLimitsCitySaved()
                   
                   if self.coordinator?.isLimitOver == true {
                       self.navigationBarStatus = .noAdd
                       MyAlert.limitBeenOver(self)
                       self.state = .presenting
                   } else {
                       if coordinator?.isPresentLocation == true {
                           MyAlert.cityAlreadySaved(self) { [weak self] in
                               guard let self = self else { return }
                               self.state = .presenting
                               self.navigationBarStatus = .allPresent
                           }
                       } else {
                           self.coordinator?.realmManager?.saveWeather(name, lat, lon)
                           callerRealmForFetching()
                           setupNavigationBarButton()
                           state = .presenting
                       }
                   }
        }
        

        
        
    }
    
    func callerRealmForFetching() {
        self.coordinator?.retriveWeather = nil
        self.coordinator?.realmManager?.delegate = self
        self.coordinator?.realmManager?.retriveWeatherForFetchManager()
    }
    
    func setupNavigationBarButton() {
        if self.coordinator?.retriveWeather?.count == 0 || self.coordinator?.retriveWeather == nil {
            self.navigationBarStatus = .noFavorite
        } else if self.coordinator?.isLimitOver == true {
            self.navigationBarStatus = .noAdd
        } else {
            self.navigationBarStatus = .allPresent
        }
    }
    
    //MARK: - Favorite Button Bar Action
    
    @objc func favoriteButtonBarWasPressed(_ sender: UIBarButtonItem) {
        coordinator?.cameFromMainViewController = nil
        coordinator?.preferedWeatherViewController()
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
            self.weatherGeneralManagerCell.removeAll()
            self.coordinator?.provenienceDelegate?.proveniceDidSelected(.mainViewController)
            //self.coordinator?.cameFromMainViewController = true
            self.fetchManager.singleWeatherDelegate = self
            self.fetchManager.getMyWeatherData(forLatitude: lat, forLongitude: lon)
//            self.coordinator?.smartManager = SmartManager(latitude: lat, longitude: lon) { weather in
//                self.currentWeather = weather
//                self.setup(weather: weather)
//            }
        }
    }
    
    
    
    func setup(weather: MainWeather) {
        DispatchQueue.main.async {
            self.currentWeatherView.setupCurrentWeatherView(weather)
            self.currentWeatherView.setupColorViewAtCondition(weather.condition)
            self.mainBackgroundImage.image = UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)
            self.weatherCondition = weather.condition
            self.imageForNavigationBar = self.mainBackgroundImage.image
            self.weatherGeneralManagerCell = weather.weathersCell
            self.callerRealmForFetching()
            self.setupNavigationBarButton()
            self.dataSource = WeatherDataSource(weathers: weather.weathersCell, condition: weather.condition)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            self.state = .presenting
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
    
}



//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

}

extension MainViewController: WeatherFetchManagerSingleLocationDelegate {
    func weatherDidFetchedAtLocation(_ weather: MainWeather) {
        
        if case .mainViewController = coordinator?.provenience {
            currentWeather = weather
            coordinator?.userLocation = weather
        }

        if case .citiesListViewController = coordinator?.provenience {
            currentWeather = weather
        }
        
        self.currentWeather = weather
        self.setup(weather: weather)
        self.coordinator?.cameFromCitiesList = false
    }
}

extension MainViewController: RealmManagerDelegate {
    func isLimitDidOver(_ isLimitOver: Bool) {
        self.coordinator?.isLimitOver = isLimitOver
    }
    
    func locationDidSaved(_ isPresent: Bool) {
        self.coordinator?.isPresentLocation = isPresent
    }
    
    func retriveWeatherDidFinisched(_ weather: Results<RealmWeatherManager>) {
        weather.forEach { print($0.name)}
        self.coordinator?.retriveWeather = weather
    }
    
    func retriveIsEmpty() {
        self.coordinator?.retriveWeather = nil
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
    
    enum State {
        case loading
        case presenting
    }
}


