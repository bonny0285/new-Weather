//
//  BaseCoordinator.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 18/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class BaseCoordinator {
    
    private(set) var childCoordinators: [BaseCoordinator] = []
    
    func start(allowsReturnToPreviousCoordinator: Bool = false) {}
    
    func finish() {}
    
    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Impossibile rimuovere il coordinator: \(coordinator). non è un coordinator child")
        }
    }
    
    func removeAllChildCoordinatorWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }
    
    func removeAllChildCoordinator() {
        childCoordinators.removeAll()
    }
}


extension BaseCoordinator: Equatable {
    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
