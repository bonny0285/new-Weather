//
//  MainCoordinator.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    let windows: UIWindow
    
    init(windows: UIWindow, navigationController: UINavigationController) {
        self.navigationController = navigationController
        //    self.navigationController.navigationBar.barTintColor = R.color.plantation()
        //    self.navigationController.navigationBar.isTranslucent = true
        //    self.navigationController.navigationBar.tintColor = .black
        self.windows = windows
    }
    
    
    func start() {
        windows.rootViewController = navigationController
        windows.makeKeyAndVisible()
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
