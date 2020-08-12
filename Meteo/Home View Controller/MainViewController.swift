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
    
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            switch condition {
            case .tempesta:
                cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var populationLabel: UILabel! {
        didSet {
            switch condition {
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
    @IBOutlet weak var weatherImage: UIImageView! {
        didSet {
            switch condition {
            case .tempesta:
                weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var weatherTemperatureLabel: UILabel! {
        didSet {
            switch condition {
            case .tempesta:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var myStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet {
            if case .neve = condition {
                backgroundImage.alpha = 0.8
            }
        }
    }
    
    @IBOutlet weak var gradiLabel: UILabel! {
        didSet {
            switch condition {
            case .tempesta:
                gradiLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggia:
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                gradiLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var gradiClabel: UILabel! {
        didSet {
            switch condition {
            case .tempesta:
                gradiClabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggia:
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                gradiClabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    
    //MARK: - Properties
    
    typealias LocationForUser = (latitude: Double,longitude: Double)
    
    var currentWeather: WeatherModel?
    var arrayForCell: [WeatherModelCell] = []
    
    let locationManager = CLLocationManager()
    
    var fetchWeather = FetchWeather()
    var language: String = ""
    var delegate: MainViewControllerLocationDelegate?
    var citiesArray: [CitiesList] = []
    
    var userLocation: LocationForUser = (0.0, 0.0)
    var realmManager = RealmManager()
    var currentLocation: LocationForUser = (0.0, 0.0)
    
    /// Properties for Prefered Weather
        
        var arrayName: [String] = []
        var arrayCell: [WeatherModelCell] = []
        var arrayConditon: [FetchWeather.WeatherCondition] = []
        var arrayImages: [UIImage] = []
        var weatherManager: WeatherManager?
        var cell: [[WeatherModelCell]] = []
    ///
    
    var state: State = .notSave {
        didSet {
            switch state {
            case .save:
                print("SAVE")
            case .notSave:
                print("NOT SAVE")
            case .loading:
                navigationController?.navigationBar.isHidden = true
            case .endLoading:
                navigationController?.navigationBar.isHidden = false
                
                navigationController?.navigationBar.barTintColor = .gray
                var locationImage = UIImage()
                var searchImage = UIImage()
                
                if #available(iOS 13.0, *) {
                    overrideUserInterfaceStyle = .light
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
                
                
                if weatherManager?.isEmptyDataBase == true {
                    navigationItem.leftBarButtonItem = leftButton
                } else {
                    navigationItem.leftBarButtonItems = [leftButton, preferredButtonItem]
                }
                
                navigationItem.rightBarButtonItems = [rightButton, addButtonItem]
            }
        }
    }
    var condition: FetchWeather.WeatherCondition = .nebbia {
        didSet {
            navigationController?.navigationBar.tintColor = .black
        }
    }
    
    
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        state = .loading
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        weatherManager = WeatherManager.init()
        
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        tableView.isHidden = true
        

        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        language = Locale.current.languageCode!
        
        myStackView.isHidden = true
        
        fetchCitiesFromJONS()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .notSave
        delegate = self
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCitiesList" {
            if let controller = segue.destination as? CitiesListViewController {
                controller.citiesResult = sender as? [CitiesList]
                controller.citiesArray = citiesArray
            }
        } else if segue.identifier == "ShowPreferredWeather" {
            if let controller = segue.destination as? PreferredWeatherViewController {
                controller.weatherManager = sender as? WeatherManagerModel
            }
        }
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}
    
    //MARK: - Actions & Functions
    
    
    @objc func rightButtonWasPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowCitiesList", sender: nil)
    }
    @objc func leftButtonWasPressed(_ sender: UIBarButtonItem) {
        prepareUIForWeather(userLocation.latitude, userLocation.longitude)
    }
    
    @objc func addButtonItemWasPressed(_ sender: UIBarButtonItem) {
        realmManager.saveWeather(cityNameLabel.text ?? "", currentLocation.latitude, currentLocation.longitude)
    }
    
    @objc func preferedButtonItemPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ShowPreferredWeather", sender: weatherManager?.weather)
    }
    
    
    func prepareUIForWeather(_ latitude: Double, _ longitude: Double){
        
        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        let loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        currentLocation.latitude = latitude
        currentLocation.longitude = longitude
        present(loadingController, animated: true) {
            self.fetchWeather.getMyWeatherData(forLatitude: latitude, forLongitude: longitude) { weather in
                
                self.currentWeather = weather
                
                self.fetchJSONAndSetupUI(weather: weather)
                self.state = .endLoading
                loadingController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func fetchJSONAndSetupUI(weather: WeatherModel) {
        
        self.myStackView.isHidden = false
        self.tableView.isHidden = false
        self.cityNameLabel.text = weather.name
        let populationText = NSLocalizedString("population_label", comment: "")
        self.populationLabel.text = "\(populationText)\(weather.population)"
        self.weatherTemperatureLabel.text = weather.temperatureString
        self.backgroundImage.image = UIImage(named: self.fetchWeather.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID).rawValue)
        self.condition = self.fetchWeather.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionID)
        
        if #available(iOS 13.0, *) {
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        } else {
            self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
        }
        
        self.arrayForCell = weather.weatherForCell
        
        self.tableView.reloadData()
        
    }
    
    
    func fetchCitiesFromJONS () {
        citiesArray.removeAll()
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            
            citiesArray = result.sorted { $0.name < $1.name}.compactMap { $0 }
            print("DONE")
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            //locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            userLocation = (lat, lon)
            prepareUIForWeather(lat, lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error Location Manager",error.localizedDescription)
    }
    
}



//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        
        cell.setupCell(arrayForCell[indexPath.row], atCondition: condition)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}


//MARK: - MainViewControlloerLocationDelegate

extension MainViewController: MainViewControllerLocationDelegate {
    func locationDidChange(_ response: CitiesList) {
        
        DispatchQueue.main.async {
            self.prepareUIForWeather(response.coord.lat, response.coord.lon)
        }
    }
    
}


extension MainViewController {
    
    enum State {
        case save
        case notSave
        case loading
        case endLoading
    }
}


