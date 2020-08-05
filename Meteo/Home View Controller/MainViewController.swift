//
//  MainViewController.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation




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
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    var arrayForCell: [WeatherCell] = []
    var fetchWeather = FetchWeather()
    var getResult: CitiesList?
    var language: String = ""
    
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
    
    var coverView: UIView {
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if #available(iOS 13.0, *) {
            debugPrint("iOS 13.0 is available")
            activityIndicator.startAnimating()
            activityIndicator.style = .large
            self.overrideUserInterfaceStyle = .light
        } else {
            debugPrint("iOS 13.0 is not available")
            activityIndicator.startAnimating()
            activityIndicator.style = .white
        }
        
        backgroundView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        return backgroundView
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchLocationButton.isHidden = true
        tableView.isHidden = true
        
        if #available(iOS 13.0, *) {
            debugPrint("iOS 13.0 is available")
            loadingBar.startAnimating()
            loadingBar.style = .large
            overrideUserInterfaceStyle = .light
            currentLocationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
            searchLocationButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        } else {
            debugPrint("iOS 13.0 is not available")
            loadingBar.startAnimating()
            loadingBar.style = .white
            currentLocationButton.setImage(UIImage(named: "address"), for: .normal)
            searchLocationButton.setImage(UIImage(named: "search"), for: .normal)
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        language = Locale.current.languageCode!
        
        myStackView.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let city = getResult {
            fetchWeather.getMyWeatherData(forLatitude: city.coord.lat, forLongitude: city.coord.lon) {(weather, weatherCell) in
                
                self.fetchJSONAndSetupUI(weather: weather, weatherCell: weatherCell)
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCitiesList" {
            if let controller = segue.destination as? CitiesListViewController {
                controller.citiesResult = sender as? [CitiesList]
                
            }
        }
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {}
    
    //MARK: - Actions & Functions
    
    @IBAction func currentLocationButtonWasPressed(_ sender: UIButton) {
        self.locationManager.requestLocation()
    }
    
    
    @IBAction func searchLocationButtonWasPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowCitiesList", sender: nil)
    }
    
    
    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            
//            let controller = (UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
//            self.present(controller, animated: true) {
//                            self.fetchWeather.getMyWeatherData(forLatitude: lat, forLongitude: lon) { (weather, weatherCell) -> (Void)? in
//                    
//                    self.fetchJSONAndSetupUI(weather: weather, weatherCell: weatherCell)
//                             
//                }
//                   controller.dismiss(animated: true, completion: nil)
//            }

            
            self.fetchWeather.getMyWeatherData(forLatitude: lat, forLongitude: lon) { (weather, weatherCell) -> (Void)? in

                self.fetchJSONAndSetupUI(weather: weather, weatherCell: weatherCell)
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func fetchJSONAndSetupUI(weather: WeatherStruct, weatherCell: [WeatherCell]) {
        DispatchQueue.main.async {
            
            self.loadingBar.stopAnimating()
            self.loadingBar.isHidden = true
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
        
        cell.setupCell(forWeather: arrayForCell[indexPath.row], atCondition: condition)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}



