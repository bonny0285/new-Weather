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
import Alamofire


protocol MainViewControllerDidGetSavedWeathers: class {
    func didGetSavedWeatherDidCompleted(_ weathers: [MainWeather])
    func isDatabaseEmpty(_ isEmpty: Bool?)
    func isLocationSaved(_ isPresent: Bool)
    func isLimitBeenOver(_ isLimitBeenOver: Bool)
}


class MainViewController: UIViewController, Storyboarded {
    
    
    //MARK: - Outlets
    @IBOutlet weak var lottieContainer: UIView!
    @IBOutlet weak var containerView: UIView!
    
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
    var currentWeather: MainWeather?
    var dataSource: WeatherDataSource?
    private var loadingView = AnimationView()
    var weatherGeneralManagerCell: [WeatherGeneralManagerCell] = []
    
    var coordinateUserLocation: LocationForUser = (0.0, 0.0)
    var timer: Timer?
    
    var navigationBarStatus: NavigationBarStatus = .noOne {
        didSet {
            
            let currentLocationButton = UIBarButtonItem(image: UIImage(named: "new_location"), style: .plain, target: self, action: #selector(currentLocationButtonBarWasPressed(_:)))
            let searchButton = UIBarButtonItem(image: UIImage(named: "new_search"), style: .plain, target: self, action: #selector(searchButtonBarWasPressed(_:)))
            let favoriteButton = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(favoriteButtonBarWasPressed(_:)))
            let addButton = UIBarButtonItem(image: UIImage(named: "new_add"), style: .plain, target: self, action: #selector(addButtonBarWasPressed(_:)))
            
            switch navigationBarStatus {
            case .allPresent:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noFavorite:
                navigationItem.leftBarButtonItems = [currentLocationButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noAdd:
                navigationItem.rightBarButtonItems = [searchButton]
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
            case .noOne:
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
                // self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                containerView.isHidden = false
                currentWeatherView.isHidden = false
                tableView.isHidden = true
                lottieContainer.isHidden = false
                mainBackgroundImage.isHidden = true
                let animation = Animation.named("loading")
                setupAnimation(for: animation!)
            case .presenting:
                // timer?.invalidate()
                containerView.isHidden = true
                currentWeatherView.isHidden = false
                tableView.isHidden = false
                lottieContainer.isHidden = true
                mainBackgroundImage.isHidden = false
                loadingView.stop()
            }
        }
    }
    
    var realmManager: RealmManager?
    var weathersRealmManager: WeatherRealmManger?
    var fetchManager: WeatherFetchManager?
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weathersRealmManager = WeatherRealmManger()
        weathersRealmManager?.delegate = self
        weathersRealmManager?.retriveData()
    
        /// Chimate alla TableView
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        
        language = Locale.current.languageCode!
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        state = .loading
        
        realmManager = RealmManager()
        realmManager?.delegate = self
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            if case .preferedViewController = coordinator?.provenience {
                realmManager?.retriveWeatherForFetchManager()
            } else if case .citiesListViewController = self.coordinator?.provenience {
                guard let lat = coordinator?.city?.coord.lat, let lon = coordinator?.city?.coord.lon else { return }
                fetchManager?.delegate = self
                fetchManager?.getMyWeatherData(forLatitude: lat, forLongitude: lon)
            }
        } else {
            #warning("Gestione Errore")
        }
        
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
    
    
    @objc func timerAction() {
        //locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //MARK: - Search Button Bar Action
    
    @objc func searchButtonBarWasPressed(_ sender: UIBarButtonItem) {
        coordinator?.cityListViewController()
    }
    
    //MARK: - Current Location Button Bar Action
    
    @objc func currentLocationButtonBarWasPressed(_ sender: UIBarButtonItem) {
        self.state = .loading
        setup(weather: (coordinator?.userLocation)!)
        self.currentWeather = coordinator?.userLocation
        let index = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: index, animated: true, scrollPosition: .top)
    }
    
    //MARK: - Add Button Bar Action
    
    @objc func addButtonBarWasPressed(_ sender: UIBarButtonItem) {
        
        state = .loading
        
        guard let city = currentWeather?.name, let latitude = currentWeather?.latitude, let longitude = currentWeather?.longitude else { return }
        
        coordinator?.provenience = .addAction
        
        if coordinator?.realmManagerCount == 10 {
            MyAlert.limitBeenOver(self) {
                self.state = .presenting
            }
        } else {
            let isPresent = realmManager?.checkForAPresentLocation(city: city)
            
            if isPresent == true {
                MyAlert.cityAlreadySaved(self) {
                    self.state = .presenting
                }
            } else {
                realmManager?.saveWeather(city, latitude, longitude)
                fetchManager?.getMyWeatherData(forLatitude: latitude, forLongitude: longitude)
            }
        }
        
    }
    
    //MARK: - Favorite Button Bar Action
    
    @objc func favoriteButtonBarWasPressed(_ sender: UIBarButtonItem) {
        coordinator?.preferedWeatherViewController()
    }
    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            coordinateUserLocation = (lat, lon)
            self.weatherGeneralManagerCell.removeAll()

            fetchManager = WeatherFetchManager()
            fetchManager?.delegate = self
            fetchManager?.getMyWeatherData(forLatitude: lat, forLongitude: lon)
        }
    }
    
    
    
    func setup(weather: MainWeather) {
        
        DispatchQueue.main.async {
            self.currentWeatherView.setupCurrentWeatherView(weather)
            self.currentWeatherView.setupColorViewAtCondition(weather.condition)
            self.mainBackgroundImage.image = UIImage(named: weather.condition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)
            self.weatherCondition = weather.condition
            
            switch self.weatherCondition {
            case .tempesta:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggiaLeggera:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .neve:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            
            self.weatherGeneralManagerCell = weather.weathersCell
            self.dataSource = WeatherDataSource(weathers: weather.weathersCell, condition: weather.condition)
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self
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

extension MainViewController: WeatherRealmManagerDelegate {
    func setupNavigationBar(_ count: Int, _ favoriteButton: Bool, _ addButton: Bool) {
        self.coordinator?.realmManagerCount = count
        
        navigationController?.navigationBar.isHidden = false
        
        if favoriteButton == true && addButton == true {
            navigationBarStatus = .allPresent
        } else if addButton == false {
            navigationBarStatus = .noAdd
        } else if favoriteButton == false {
            navigationBarStatus = .noFavorite
        }
        
        if case .mainCoordinator =  coordinator?.provenience {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        } else if case .preferedViewController = coordinator?.provenience {
            DispatchQueue.main.async {
                self.setup(weather: self.currentWeather!)
            }
        }
    }
    
    func weathersDidFetched(_ weathers: [MainWeather]?) {
        if let weathers = weathers {
            self.coordinator?.savedWeathers = weathers
        }
        
    }
}


extension MainViewController: WeatherSingleFetchDelegate {

    func singleWeather(_ weather: MainWeather) {
        
        if case .mainCoordinator =  coordinator?.provenience {
            currentWeather = weather
            coordinator?.userLocation = weather
            self.setup(weather: weather)
        }
        
        if case .citiesListViewController = coordinator?.provenience {
            currentWeather = weather
            self.setup(weather: weather)
        }

        if case .addAction = self.coordinator?.provenience {
            coordinator?.savedWeathers.append(weather)
            
            state = .presenting
        } 
    }
    
    func didGetError(_ error: String) {
        ///Manage Error
    }
}



//MARK: - State

extension MainViewController {
    
    enum NavigationBarStatus{
        case allPresent
        case noFavorite
        case noAdd
        case noOne
    }
    
    enum State {
        case loading
        case presenting
    }
}






