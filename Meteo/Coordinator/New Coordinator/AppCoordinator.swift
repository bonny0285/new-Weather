//
//  AppCoordinator.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    
    override func start(allowsReturnToPreviousCoordinator: Bool) {
        guard let window = window else { return }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let dashboardCoordinator = DashboardCoordinator(rootNavigationController: rootViewController)
        addChildCoordinator(dashboardCoordinator)
        dashboardCoordinator.start(allowsReturnToPreviousCoordinator: allowsReturnToPreviousCoordinator)
    }
    
    override func finish() {}
    
}
