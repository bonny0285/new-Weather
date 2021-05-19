//
//  DashboardCoordinator.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {
    let rootNavigationController: UINavigationController!
    private(set) var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    //MARK: - Lifecycle

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    override func start(allowsReturnToPreviousCoordinator: Bool) {
        let loginViewController: DashboardViewController = storyboard.instantiateViewController(identifier: "DashboardViewController")
        //loginViewController.viewModel = loginViewModel
       // loginViewController.viewModel.delegate = self
        
        if allowsReturnToPreviousCoordinator {
            rootNavigationController.pushViewController(loginViewController, animated: true)
        } else {
            rootNavigationController.setViewControllers([loginViewController], animated: true)
        }
    }
    
    override func finish() {}
}
