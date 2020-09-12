//
//  MainCoordinator.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift


protocol ProvenienceDelegate: class {
    func proveniceDidSelected(_ provenience: MainCoordinator.Provenience)
}

class MainCoordinator: Coordinator {

    //MARK: - Main Properies
    var children = [Coordinator]()
    var navigationController: UINavigationController
    let windows: UIWindow
    
    //MARK: - Properties

    //MARK: - RealmManager
    var realmManager: RealmManager?
    var retriveWeather: Results<RealmWeatherManager>?
    var fetchManager = WeatherFetchManager()
    var savedWeather: [MainWeather]?
    var isPresentLocation: Bool? = nil
    var isLimitOver: Bool? = nil
    
    //MARK: - Navigation Properies
    var provenience: Provenience?
    var provenienceDelegate: ProvenienceDelegate?

    
    //MARK: - User Location
    var userLocation: MainWeather?
    
    //MARK: - Cities List
    var allCitiesList: AllCitiesList?
    var city: CitiesList?
    
    //MARK: - Lifecycle

    init(windows: UIWindow, navigationController: UINavigationController) {
        self.windows = windows
        self.navigationController = navigationController
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
        
        self.provenienceDelegate = self
        self.allCitiesList = AllCitiesList()
        
        self.realmManager = RealmManager()
        self.realmManager?.delegate = self
        self.realmManager?.retriveWeatherForFetchManager()
        self.realmManager?.checkForLimitsCitySaved()
        
        if self.retriveWeather != nil {
            self.fetchManager.delegate = self
            self.fetchManager.retriveMultipleLocation(for: retriveWeather!)
        }
        
    }
    
    
    //MARK: - COORDINATOR'S NAVIGATION

    func start() {
        windows.rootViewController = navigationController
        windows.makeKeyAndVisible()
        let controller = MainViewController.instantiate()
        controller.coordinator = self
        realmManager = RealmManager()
        navigationController.pushViewController(controller, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func mainViewController() {
        let controller = MainViewController.instantiate()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func cityListViewController() {
        let controller = CitiesListViewController.instantiate()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func preferedWeatherViewController() {
        let controller = PreferredWeatherViewController.instantiate()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
}

//MARK: - Realm Manager Delegate

extension MainCoordinator:  RealmManagerDelegate {
    
    func isLimitDidOver(_ isLimitOver: Bool) {
        self.isLimitOver = isLimitOver
    }
    
    func locationDidSaved(_ isPresent: Bool) {
        self.isPresentLocation = isPresent
    }
    
    func retriveWeatherDidFinisched(_ weather: Results<RealmWeatherManager>) {
        self.retriveWeather = weather
    }
    
    func retriveIsEmpty() {
        self.retriveWeather = nil
    }

}


extension MainCoordinator {
    enum Provenience {
        case mainViewController
        case citiesListViewController
        case preferedViewController
        case mainCoordinator
    }
}

extension MainCoordinator: ProvenienceDelegate {
    func proveniceDidSelected(_ provenience: Provenience) {
        self.provenience = provenience
    }
}

extension MainCoordinator: WeatherFetchManagerPreferedDelegate {
    func didGetError(_ error: String) {
        debugPrint(error)
    }
    
    func getArrayData(_ weather: [MainWeather]) {
        self.savedWeather = weather
    }
}
