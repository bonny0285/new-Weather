//
//  DashboardViewController.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
//import CoreLocation
import Combine

class DashboardViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var mainWeatherImage: UIImageView!
    
    // MIDDLE SCROLL VIEW
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    // BOTTOM LABEL
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    //MARK: - Properties
    
    var viewModel = DashboardViewModel()
    var language: String { Locale.current.languageCode! }
    var cancelBag = Set<AnyCancellable>()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.$_weatherObject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self, let result = result else { return }
                self.setupUIForWeather(result)
            }
            .store(in: &cancelBag)
        
        createBarButtonMenu()
    }
    
    private func createBarButtonMenu() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        let button = UIButton()
        button.addTarget(self, action: #selector(menuIsPressed(_:)), for: .touchUpInside)
        let menuImage = UIImage(named: "menu")
        button.setImage(menuImage, for: .normal)
        
        navigationBar.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let height = (navigationBar.frame.height - 10)
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.widthAnchor.constraint(equalToConstant: height).isActive = true
        button.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc func menuIsPressed(_ sender: UIButton) {
        viewModel.delegate?.openSideMenu(
            parent: self,
            height: view.frame.height,
            width: view.frame.width,
            navigationBarHeight: navigationController?.navigationBar.frame.height ?? 0
        )
    }
    
    //MARK: - Methods

    private func setupUIForWeather(_ weather: JSONObject) {
        let temp = weather.list.first!.main.temp.temperatureString
        self.title = "\(weather.city.name) \(temp)°C"
        self.populationLabel.text = "Population: \(weather.city.population)"
        self.mainWeatherImage.image = (weather.list.first?.weather.first?.id.weatherImage)
        self.sunriseLabel.text = weather.city.sunrise.transformTimestampToString()
        self.sunsetLabel.text = weather.city.sunset.transformTimestampToString()
        self.setupMiddleWeatherCards(with: weather.list)
    }
    
    private func setupMiddleWeatherCards(with list: [List]) {
        horizontalScrollView.subviews.forEach { $0.removeFromSuperview() }
        
        var containerView: [UIView] = []
        
        for i in 0 ..< list.count {
            let middleView = WeatherMiddleView()
            middleView.viewModel = WeatherMiddleView.ViewModel(
                weatherImage: list[i].weather.first!.id.weatherBackgroundImage,
                weatherTime: list[i].txt.stringDateString,
                weatherDescription: list[i].weather.first!.description,
                tempMax: list[i].main.temp_max.temperatureString,
                tempMin: list[i].main.temp_min.temperatureString
            )
            
            let containerMiddleView = UIView()
            containerMiddleView.addSubview(middleView)
            
            middleView.translatesAutoresizingMaskIntoConstraints = false
            middleView.heightAnchor.constraint(equalToConstant: horizontalScrollView.frame.height).isActive = true
            //middleView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor, constant: 0).isActive = true
            middleView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            middleView.topAnchor.constraint(equalTo: containerMiddleView.topAnchor).isActive = true
            middleView.bottomAnchor.constraint(equalTo: containerMiddleView.bottomAnchor).isActive = true
            middleView.trailingAnchor.constraint(equalTo: containerMiddleView.trailingAnchor).isActive = true
            middleView.leadingAnchor.constraint(equalTo: containerMiddleView.leadingAnchor).isActive = true
            
            containerView.append(containerMiddleView)
        }
        
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.contentSize = CGSize(
            width: Int(self.view.frame.width) * list.count,
            height: 1
        )
        
        let stack = UIStackView(arrangedSubviews: containerView)
        stack.axis = .horizontal
        
        horizontalScrollView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor).isActive = true 
        stack.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 0).isActive = true
        stack.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 0).isActive = true
        stack.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor, constant: 0).isActive = true
        stack.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor, constant: 0).isActive = true
    }
    
    //MARK: - Actions


}

extension DashboardViewController: SideMenuViewControllerDelegate {
    func sideMenuDidPressOption(_ option: String) {
        
    }
    
    func sideMenuDidPressLogout() {
        
    }
    
    func sideMenuDidPressPrivacy() {
        
    }
    
    func sideMenuDidPressSupport() {
        
    }
    
    func sideMenuDidPressUserProfile() {
        
    }
}







