//
//  ConstraintBuilder.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 25/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class ConstraintBuilder: NSObject {
    
    static func setupAllEdgesConstrainFor(child view: UIView, into parentView: UIView) {
        parentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
    }
    
    static func setupConstraintFor(isEmbedded: Bool = false, child view: UIView, into parentView: UIView, constraints: [ConstraintType]) {
        
        if isEmbedded == false {
            parentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    
        for constraint in constraints {
            runThroughConstraintType(constraint, child: view, parentView: parentView)
        }
    }
    
    private static func runThroughConstraintType(_ constraintType: ConstraintType, child view: UIView, parentView: UIView) {
        switch constraintType {
        case .top(constant: let constant):
            view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: constant).isActive = true
            
        case .bottom(constant: let constant):
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: constant).isActive = true
            
        case .trailing(constant: let constant):
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: constant).isActive = true
            
        case .leading(constant: let constant):
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constant).isActive = true
            
        case .height(constant: let constant):
            view.heightAnchor.constraint(equalToConstant: constant).isActive = true
            
        case .width(constant: let constant):
            view.widthAnchor.constraint(equalToConstant: constant).isActive = true
            
        case .centerX(constant: let constant):
            view.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: constant).isActive = true
            
        case .centerY(constant: let constant):
            view.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: constant).isActive = true
        }
    }
}


extension ConstraintBuilder {
    enum ConstraintType {
        case top(constant: CGFloat = 0)
        case bottom(constant: CGFloat = 0)
        case trailing(constant: CGFloat = 0)
        case leading(constant: CGFloat = 0)
        case height(constant: CGFloat = 0)
        case width(constant: CGFloat = 0)
        case centerX(constant: CGFloat = 0)
        case centerY(constant: CGFloat = 0)
    }
}

