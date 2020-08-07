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
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var gradiLabel: UILabel!
    @IBOutlet weak var gradiClabel: UILabel!
    
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    var arrayForCell: [WeatherCell] = []
    var fetchWeather = FetchWeather()
    var language: String = ""
    var delegate: MainViewControllerLocationDelegate?
    var citiesArray: [CitiesList] = []
    typealias LocationForUser = (latitude: Double,longitude: Double)
    var userLocation: LocationForUser = (0.0, 0.0)
    
    var condition: FetchWeather.WeatherCondition = .nebbia {
        didSet {
            switch condition {
            case .tempesta:
                debugPrint("Tempesta")
                cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                gradiLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .pioggia:
                debugPrint("pioggia")
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                currentLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                searchLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .pioggiaLeggera:
                debugPrint("pioggia leggera")
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                currentLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                searchLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .neve:
                debugPrint("Neve")
                self.backgroundImage.alpha = 0.8
                cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                gradiLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                gradiClabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .nebbia:
                debugPrint("Nebbia")
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .sole:
                debugPrint("Sole")
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .nuvole:
                debugPrint("Nuvole")
                cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
    
    
    @IBAction func searchLocationButtonWasPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ShowCitiesList", sender: nil)   
    }
    
    
    func prepareUIForWeather(_ latitude: Double, _ longitude: Double){
        
        let storyboard = UIStoryboard(name: "loading", bundle: nil)
        let loadingController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        
        present(loadingController, animated: true) {
            self.fetchWeather.getMyWeatherData(forLatitude: latitude, forLongitude: longitude) { (weather, weatherCell) -> () in
                self.fetchJSONAndSetupUI(weather: weather, weatherCell: weatherCell)
                loadingController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func fetchJSONAndSetupUI(weather: WeatherStruct, weatherCell: [WeatherCell]) {
        //DispatchQueue.main.async {
            
            self.myStackView.isHidden = false
            self.tableView.isHidden = false
            self.searchLocationButton.isHidden = false
            self.cityNameLabel.text = weather.nome
            let populationText = NSLocalizedString("population_label", comment: "")
            self.populationLabel.text = "\(populationText)\(weather.population)"
            self.weatherTemperatureLabel.text = weather.temperatureString
            self.backgroundImage.image = UIImage(named: self.fetchWeather.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionId).rawValue)
            self.condition = self.fetchWeather.weatherCondition.getWeatherConditionFromID(weatherID: weather.conditionId)
            
            if #available(iOS 13.0, *) {
                self.weatherImage.image = UIImage(systemName: weather.conditionName)
            } else {
                self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
            }
            
            self.arrayForCell = weatherCell
            self.tableView.reloadData()
      //  }
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
        //locationManager.stopUpdatingLocation()
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
        
        cell.setupCell(forWeather: arrayForCell[indexPath.row], atCondition: condition)
        
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

