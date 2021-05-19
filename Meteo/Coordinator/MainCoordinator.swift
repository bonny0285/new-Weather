//
//  MainCoordinator.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift
import Lottie
import Alamofire


//class MainCoordinator: Coordinator {
//
//    //MARK: - Main Properies
//    var children = [Coordinator]()
//    var navigationController: UINavigationController
//    let windows: UIWindow
//    
//    //MARK: - Properties
//
//    //MARK: - Navigation Properies
//    var provenience: Provenience?
//    
//    //MARK: - User Location
//    var userLocation: MainWeather?
//    
//    //MARK: - Cities List
//    var allCitiesList: AllCitiesList?
//    var city: CitiesList? = nil
//
//    
//    var savedWeathers: [MainWeather] = []
//    
//    var realmManagerCount: Int = 0
//    
//    //MARK: - Lifecycle
//
//    init(windows: UIWindow, navigationController: UINavigationController) {
//        self.windows = windows
//        self.navigationController = navigationController
//        
//        navigationController.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController.navigationBar.shadowImage = UIImage()
//        navigationController.navigationBar.isTranslucent = true
//        navigationController.view.backgroundColor = .clear
//        
//        self.allCitiesList = AllCitiesList()
//
//    }
//    
//    
//    //MARK: - COORDINATOR'S NAVIGATION
//
//    func start() {
//        windows.rootViewController = navigationController
//        windows.makeKeyAndVisible()
//        let controller = MainViewController.instantiate()
//        controller.coordinator = self
//        provenience = .mainCoordinator
//        navigationController.pushViewController(controller, animated: true)
//    }
//    
//    func popViewController() {
//        navigationController.popViewController(animated: true)
//    }
//    
//    func mainViewController() {
//        let controller = MainViewController.instantiate()
//        controller.coordinator = self
//        navigationController.pushViewController(controller, animated: true)
//    }
//    
//    func cityListViewController() {
//        let controller = CitiesListViewController.instantiate()
//        controller.coordinator = self
//        navigationController.pushViewController(controller, animated: true)
//    }
//    
//    func preferedWeatherViewController() {
//        let controller = PreferredWeatherViewController.instantiate()
//        controller.coordinator = self
//        navigationController.pushViewController(controller, animated: true)
//    }
//    
//}
//
//
//extension MainCoordinator {
//    enum Provenience {
//        case mainViewController
//        case citiesListViewController
//        case preferedViewController
//        case mainCoordinator
//        case addAction
//    }
//}
//
//
//
//
