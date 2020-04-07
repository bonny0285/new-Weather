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

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchLocationTextField: UITextField!
    @IBOutlet weak var searchLocationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var gradiLabel: UILabel!
    @IBOutlet weak var gradiClabel: UILabel!
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    
    
    
    let locationManager = CLLocationManager()
    var arrayForCell: [WeatherCell] = []
    var weatherBackground: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingBar.startAnimating()
        searchLocationTextField.isHidden = true
        tableView.isHidden = true
        
        if #available(iOS 13.0, *) {
            print("iOS 13.0 is available")
            loadingBar.startAnimating()
            loadingBar.style = .large
            overrideUserInterfaceStyle = .light
            currentLocationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
            searchLocationButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        } else {
            print("iOS 13.0 is not available")
            loadingBar.startAnimating()
            loadingBar.style = .white
            currentLocationButton.setImage(UIImage(named: "address"), for: .normal)
            searchLocationButton.setImage(UIImage(named: "search"), for: .normal)
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchLocationTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        myStackView.isHidden = true
        
        WeatherModel.delegate = self
        
//        WeatherModel.getMyWeatherData(forLatitude: 42.243, forLongitude: 12.346)
        
    }
    
    

    
    
    @IBAction func currentLocationButtonWasPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    @IBAction func searchLocationButtonWasPressed(_ sender: UIButton) {

        searchLocationTextField.endEditing(true)
        
    }
    
    
    
    
    
    
    func setColorUIViewForBackground(forCell cell : WeatherTableViewCell,forBackground backgroundImage: String){
        
        switch backgroundImage {
        case "tempesta":
            print("Tempesta")
            searchLocationTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            searchLocationTextField.attributedPlaceholder = NSAttributedString(string:"Type something here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            gradiLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            gradiClabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case "pioggia":
            print("pioggia")
            searchLocationTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            searchLocationTextField.attributedPlaceholder = NSAttributedString(string:"Type something here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            searchLocationButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "neve":
            print("Neve")
            searchLocationTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.backgroundImage.alpha = 0.8
            searchLocationTextField.attributedPlaceholder = NSAttributedString(string:"Type something here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            cityNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            populationLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            weatherTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            currentLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            searchLocationButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            gradiLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            gradiClabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "nebbia":
            print("Nebbia")
            cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "sole":
            print("Sole")
            searchLocationTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            searchLocationTextField.attributedPlaceholder = NSAttributedString(string:"Type something here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "nuvole":
            print("Nuvole")
            searchLocationTextField.attributedPlaceholder = NSAttributedString(string:"Type something here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            searchLocationTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cityNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            populationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherImage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            weatherTemperatureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            currentLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            searchLocationButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            gradiClabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            print("Default")
        }
    }
    
    


}


//MARK: - WeatherDelegate

extension MainViewController: WeatherDelegate{
    
    
    
    func getDataForCell(weather: [WeatherCell]) {
        
        DispatchQueue.main.async {
            self.arrayForCell = weather
            self.tableView.reloadData()
        }
        
    }
    
    
    
    func getData(weather: WeatherStruct) {
        print(#function)
        print(weather.nome, weather.conditionId)
        
          DispatchQueue.main.async {
            
            self.loadingBar.stopAnimating()
            self.loadingBar.isHidden = true
            self.myStackView.isHidden = false
            self.tableView.isHidden = false
            self.searchLocationTextField.isHidden = false
            self.cityNameLabel.text = weather.nome
            self.populationLabel.text = "Population: \(weather.population)"
            self.weatherTemperatureLabel.text = weather.temperatureString
            self.backgroundImage.image = UIImage(named: WeatherModel.setImageBackground(forID: weather.conditionId))
            self.weatherBackground = WeatherModel.setImageBackground(forID: weather.conditionId)
            
            
            
            
            if #available(iOS 13.0, *) {
                self.weatherImage.image = UIImage(systemName: weather.conditionName)
            } else {
                self.weatherImage.image = UIImage(named: weather.conditionNameOldVersion)
            }
            
            let cell = WeatherTableViewCell()
            self.setColorUIViewForBackground(forCell: cell, forBackground: self.weatherBackground)
            
        }
        
        
        
    }
    

    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            WeatherModel.getMyWeatherData(forLatitude: lat, forLongitude: lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate{

   
    //Delegate comunicate when the user tap "GO" on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchLocationTextField.endEditing(true)
        return true
    }
    
    //Delegate comunicate when you have finished to type and clean the TextField
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchLocationTextField.text{
            WeatherModel.getMyWeatherDataByCity(forCity: city)
        }
        searchLocationTextField.text = ""
        searchLocationTextField.endEditing(true)
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchLocationTextField.text != ""{
            return true
        } else {
            searchLocationTextField.placeholder = "Type something here!"
            return false
        }
    }
    
}



//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayForCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        
        
        cell.setupCell(forWeather: arrayForCell[indexPath.row], forBackground: weatherBackground)
            
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}





