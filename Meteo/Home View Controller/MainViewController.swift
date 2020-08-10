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
    @IBOutlet weak var currentLocationButton: UIButton! {
        didSet {
            switch condition {
            case .tempesta:
                currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                currentLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggiaLeggera:
                currentLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .neve:
                currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var searchLocationButton: UIButton! {
        didSet {
            switch condition {
            case .tempesta:
                searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                searchLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggiaLeggera:
                searchLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .neve:
                searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
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
    
    @IBOutlet weak var preferredButton: UIButton! {
        didSet {
            preferredButton.setTitle(NSLocalizedString("preferred_button_label", comment: ""), for: .normal)
            
            switch condition {
            case .tempesta:
                preferredButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                preferredButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                preferredButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                preferredButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                preferredButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                preferredButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                preferredButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.setTitle(NSLocalizedString("add_button_label", comment: ""), for: .normal)
            
            switch condition {
            case .tempesta:
                addButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pioggia:
                addButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                addButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                addButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                addButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                addButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                addButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    var state: State = .notSave
    var condition: FetchWeather.WeatherCondition = .nebbia
        
    
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Smart Forecast"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchLocationButton.isHidden = true
        tableView.isHidden = true
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            currentLocationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
            searchLocationButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        } else {
            currentLocationButton.setImage(UIImage(named: "address"), for: .normal)
            searchLocationButton.setImage(UIImage(named: "search"), for: .normal)
        }
        
        
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
        }
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}
    
    //MARK: - Actions & Functions
    
    @IBAction func currentLocationButtonWasPressed(_ sender: UIButton) {
        prepareUIForWeather(userLocation.latitude, userLocation.longitude)
    }
    
    @IBAction func addButtonWasPressed(_ sender: Any) {
        realmManager.saveWeather(cityNameLabel.text ?? "", currentLocation.latitude, currentLocation.longitude)
    }
    
    
    @IBAction func preferredButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowPreferredWeather", sender: nil)
    }
    
    @IBAction func searchLocationButtonWasPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ShowCitiesList", sender: nil)   
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
                
                loadingController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func fetchJSONAndSetupUI(weather: WeatherModel) {
        
            self.myStackView.isHidden = false
            self.tableView.isHidden = false
            self.searchLocationButton.isHidden = false
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
    }
}

