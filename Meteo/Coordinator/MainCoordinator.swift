//
//  MainCoordinator.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class MainCoordinator: Coordinator {

    
    var children = [Coordinator]()
    var navigationController: UINavigationController
    let windows: UIWindow
    var realmManager: RealmManager?
    
    var cameFromCitiesList: Bool? = nil
    var cameFromPreferedWeather: Bool? = nil
    var smartManager: SmartManager?
    var retriveWeather: Results<RealmWeatherManager>?
    var isPresentLocation: Bool? = nil
    var isLimitOver: Bool? = nil
    
    init(windows: UIWindow, navigationController: UINavigationController) {
        self.windows = windows
        self.navigationController = navigationController
        
        self.realmManager = RealmManager()
        self.realmManager?.delegate = self
        self.realmManager?.retriveWeatherForFetchManager()
        self.realmManager?.checkForLimitsCitySaved()
    }
    
    
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
