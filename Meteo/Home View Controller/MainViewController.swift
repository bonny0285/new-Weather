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



protocol MainViewControllerLocationDelegate: class {
    func locationDidChange(_ response: CitiesList)
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
    var delegate: MainViewControllerLocationDelegate?
    var currentWeather: MainWeather?
    var dataSource: WeatherDataSource?
    private var loadingView = AnimationView()
    var weatherGeneralManagerCell: [WeatherGeneralManagerCell] = []
    let fetchManager = WeatherFetchManager()
    var coordinateUserLocation: LocationForUser = (0.0, 0.0)
    var timer: Timer?
    
    var navigationBarStatus: NavigationBarStatus = .noOne {
        didSet {
            navigationController?.navigationBar.isHidden = false
            let currentLocationButton = UIBarButtonItem(image: UIImage(named: "new_location"), style: .plain, target: self, action: #selector(currentLocationButtonBarWasPressed(_:)))
            let searchButton = UIBarButtonItem(image: UIImage(named: "new_search"), style: .plain, target: self, action: #selector(searchButtonBarWasPressed(_:)))
            let favoriteButton = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(favoriteButtonBarWasPressed(_:)))
            let addButton = UIBarButtonItem(image: UIImage(named: "new_add"), style: .plain, target: self, action: #selector(addButtonBarWasPressed(_:)))
            
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.view.backgroundColor = .clear
            
            switch navigationBarStatus {
            case .allPresent:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noCurrentLocation:
                navigationItem.leftBarButtonItems = [favoriteButton]
                //navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noFavorite:
                navigationItem.leftBarButtonItems = [currentLocationButton]
                //navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .noAdd:
                //navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [searchButton]
            case .noSearch:
                //navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
                navigationItem.rightBarButtonItems = [addButton]
            case .noOne:
                navigationController?.navigationBar.isHidden = true
                navigationItem.leftBarButtonItems = nil
                navigationItem.rightBarButtonItems = nil
            case .justRight:
                navigationItem.rightBarButtonItems = [searchButton, addButton]
            case .justLeft:
                navigationItem.leftBarButtonItems = [currentLocationButton, favoriteButton]
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
                navigationBarStatus = .noOne
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
    
    var weatherError: WeatherError?
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Chimate alla TableView
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        
        language = Locale.current.languageCode!
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .loading
        
        weatherError = WeatherError()
        weatherError?.delegate = self
        
        if NetworkReachabilityManager()?.isReachable == true {
            if let _ = coordinator?.savedWeather?.didGetError {
                
                self.coordinator?.savedWeather = SavedWeather()
                
            } else {
                if case .citiesListViewController = self.coordinator?.provenience {
                    ///state = .loading
                    guard let lat = coordinator?.city?.coord.lat, let lon = coordinator?.city?.coord.lon else { return }
                    
                    fetchManager.delegate = self
                    fetchManager.getMyWeatherData(forLatitude: lat, forLongitude: lon)
                } else if case .preferedViewController = coordinator?.provenience {
                    DispatchQueue.main.async {
                        self.setup(weather: self.currentWeather!)
                    }
                } else if case .mainViewController = self.coordinator?.provenience {
                    locationManager.delegate = self
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.requestLocation()
                }
                
                tableView.delegate = self
                tableView.reloadData()
            }
        } else {
            weatherError?.delegate?.singleError()
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
        self.coordinator?.provenience = .mainViewController
        setup(weather: (coordinator?.userLocation)!)
        self.currentWeather = coordinator?.userLocation
        let index = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: index, animated: true, scrollPosition: .top)
    }
    
    //MARK: - Add Button Bar Action
    
    @objc func addButtonBarWasPressed(_ sender: UIBarButtonItem) {
        
        state = .loading
        
        if self.coordinator?.savedWeather?.isLimitOver == false {
            self.coordinator?.savedWeather?.realmManager?.delegate = self
            self.coordinator?.savedWeather?.realmManager?.checkForAPresentLocation(city: currentWeather?.name ?? "")
            
            if self.coordinator?.savedWeather?.isLocationSaved == true {
                print("Location already saved")
                MyAlert.cityAlreadySaved(self) {
                    if self.coordinator?.savedWeather?.isLimitOver == true {
                        self.navigationBarStatus = .noAdd
                    } else {
                        self.navigationBarStatus = .allPresent
                    }
                    self.state = .presenting
                }
                
            } else {
                if case .mainViewController = self.coordinator?.provenience {
                    self.coordinator?.provenience = .addAction
                    self.fetchManager.delegate = self
                    self.fetchManager.getMyWeatherData(forLatitude: currentWeather?.latitude ?? 0.0, forLongitude: currentWeather?.longitude ?? 0.0)
                    self.coordinator?.savedWeather?.realmManager?.delegate = self
                    self.coordinator?.savedWeather?.realmManager?.saveWeather(self.currentWeather?.name ?? "", self.currentWeather?.latitude ?? 0.0, self.currentWeather?.longitude ?? 0.0)
                    self.coordinator?.savedWeather?.realmManager?.retriveWeatherForFetchManager()
                    self.coordinator?.savedWeather?.realmManager?.checkForLimitsCitySaved()
                    self.state = .presenting
                } else {
                    self.coordinator?.provenience = .preferedViewController
                    self.fetchManager.delegate = self
                    self.fetchManager.getMyWeatherData(forLatitude: currentWeather?.latitude ?? 0.0, forLongitude: currentWeather?.longitude ?? 0.0)
                    self.coordinator?.savedWeather?.realmManager?.delegate = self
                    self.coordinator?.savedWeather?.realmManager?.saveWeather(self.currentWeather?.name ?? "", self.currentWeather?.latitude ?? 0.0, self.currentWeather?.longitude ?? 0.0)
                    self.coordinator?.savedWeather?.realmManager?.retriveWeatherForFetchManager()
                    self.coordinator?.savedWeather?.realmManager?.checkForLimitsCitySaved()
                    self.state = .presenting
                }

            }
            
        } else {
            self.navigationBarStatus = .noAdd
            state = .presenting
        }
           
    }
    
    
    func setupNavigationBarButton() {
        
        if self.coordinator?.savedWeather?.weatherResults?.count == 0 || self.coordinator?.savedWeather?.isDatabaseEmpty == true {
            self.navigationBarStatus = .noFavorite
        } else if self.coordinator?.savedWeather?.isLimitOver == true {
            self.navigationBarStatus = .noAdd
        } else {
            self.navigationBarStatus = .allPresent
        }
        
    }
    
    //MARK: - Favorite Button Bar Action
    
    @objc func favoriteButtonBarWasPressed(_ sender: UIBarButtonItem) {
        
        if self.coordinator?.savedWeather?.didGetError == true {
            /// Ricaricare tutti i weather salòvati
        } else {
            coordinator?.preferedWeatherViewController()
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
            self.weatherGeneralManagerCell.removeAll()
            self.coordinator?.provenienceDelegate?.proveniceDidSelected(.mainViewController)
            self.fetchManager.delegate = self
            self.fetchManager.getMyWeatherData(forLatitude: lat, forLongitude: lon)
        }
    }
    
    
    
    func setup(weather: MainWeather) {
        self.coordinator?.savedWeather?.realmManager?.delegate = self
        self.coordinator?.savedWeather?.realmManager?.retriveWeatherForFetchManager()
        self.coordinator?.savedWeather?.realmManager?.checkForLimitsCitySaved()
        
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

//MARK: - RealmManagerDelegate

extension MainViewController: RealmManagerDelegate {
    func retriveWeatherDidFinisched(_ weather: Results<RealmWeatherManager>) {
        self.coordinator?.savedWeather?.weatherResults = weather
    }
    
    func retriveIsEmpty(_ isEmpty: Bool?) {
        self.coordinator?.savedWeather?.isDatabaseEmpty = isEmpty
        
        if isEmpty == true {
            self.navigationBarStatus = .noFavorite
        } else {
            self.navigationBarStatus = .justLeft
        }
    
    }
    
    func locationDidSaved(_ isPresent: Bool) {
        self.coordinator?.savedWeather?.isLocationSaved = isPresent
    }
    
    func isLimitDidOver(_ isLimitOver: Bool) {
        self.coordinator?.savedWeather?.isLimitOver = isLimitOver
        
        if isLimitOver {
            self.navigationBarStatus = .noAdd
        } else {
            self.navigationBarStatus = .justRight
        }
    }
}

//MARK: - WeatherFetchDelegate

extension MainViewController: WeatherFetchDelegate {
    func multipleWeather(_ weathers: [MainWeather]) {
        
    }
    
    func singleWeather(_ weather: MainWeather) {
        if case .mainViewController = coordinator?.provenience {
            currentWeather = weather
            coordinator?.userLocation = weather
        }

        if case .citiesListViewController = coordinator?.provenience {
            currentWeather = weather
        }
        
        if case .addAction = self.coordinator?.provenience {
            currentWeather = weather
            self.coordinator?.savedWeather?.retriveWeathers?.append(weather)
        }
        
        if case .preferedViewController = self.coordinator?.provenience {
            self.coordinator?.savedWeather?.retriveWeathers?.append(weather)
        }
        
        self.currentWeather = weather
        self.setup(weather: weather)
    }
    
    func didGetError(_ error: String) {
        debugPrint("ERROR FETCHING CURRENT WEATHER",error)
        
        let action = UIAlertAction(title: "OK", style: .cancel) {[weak self] (action) in
            guard let self = self else { return }
            //self.state = .loading
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestLocation()
        }
        
        let controller = UIAlertController(title: NSLocalizedString("attention_alert_title", comment: ""), message: NSLocalizedString("alert_message", comment: ""), preferredStyle: .alert)
        controller.addAction(action)
        
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: - SavedWeatherDelegate

extension MainViewController: SavedWeatherDelegate {
    func retriveDidGetError(_ didGetError: Bool?) {
        guard let error = didGetError else { return }
        
        debugPrint("ERRORE FETCHING PREFERED WEATHER")
        
        if error == true {
            let action = UIAlertAction(title: "OK", style: .cancel) {[weak self] (action) in
                guard let self = self else { return }
                //self.state = .loading
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestLocation()
            }
            
            let controller = UIAlertController(title: NSLocalizedString("attention_alert_title", comment: ""), message: NSLocalizedString("alert_message", comment: ""), preferredStyle: .alert)
            controller.addAction(action)
            
            self.present(controller, animated: true, completion: nil)
        }
        
        
    }

}

//MARK: - WeatherErrorDelegate

extension MainViewController: WeatherErrorDelegate {
    func genericError() {
        
    }
    
    func singleError() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func multipleError() {
        
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
        case justRight
        case justLeft
    }
    
    enum State {
        case loading
        case presenting
    }
}


