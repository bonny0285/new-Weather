//
//  DashboardCoordinator.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {
    
    //MARK: - Properties
    
    let rootNavigationController: UINavigationController!
    private(set) var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    private lazy var sideMenu: SideMenuViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: "SideMenuViewController") as SideMenuViewController
    }()
    
    //MARK: - Lifecycle

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    override func start(allowsReturnToPreviousCoordinator: Bool) {
        let loginViewController: DashboardViewController = storyboard.instantiateViewController(identifier: "DashboardViewController")
        loginViewController.viewModel.delegate = self
       // loginViewController.viewModel.delegate = self
        
        if allowsReturnToPreviousCoordinator {
            rootNavigationController.pushViewController(loginViewController, animated: true)
        } else {
            rootNavigationController.setViewControllers([loginViewController], animated: true)
        }
    }
    
    override func finish() {}
}

extension DashboardCoordinator: DashboardViewModelDelegate {
    func openSideMenu(parent: UIViewController & SideMenuViewControllerDelegate, height: CGFloat, width: CGFloat, navigationBarHeight: CGFloat) {
        
        guard sideMenu.isPresent || sideMenu.isClosed else { return }

        if sideMenu.isPresent {
            sideMenu.close(parent: parent, withDuration: 0.2)
        } else if sideMenu.isClosed {
            sideMenu.open(
                parent: parent,
                width: width,
                height: height,
                navigationBarHeight: navigationBarHeight
            )
        }
        
    }
}
