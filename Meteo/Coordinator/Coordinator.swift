//
//  Coordinator.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 07/09/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }

    func start()
    func coordinate(to cordinator: Coordinator)
}

extension Coordinator {
    
    func coordinate(to cordinator: Coordinator) {
        start()
    }
}
