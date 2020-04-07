//
//  MyAlert.swift
//  Meteo
//
//  Created by Massimiliano on 04/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

//MARK: - MyAlert
public struct MyAlert{
    
    
//MARK: - AlertError
    public static func alertError(forError error: String, forViewController controller: UIViewController){
        let controller = UIAlertController(title: "Attention !!!", message: "\(error)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        controller.addAction(action)
        controller.present(controller, animated: true, completion: nil)
    }
}
