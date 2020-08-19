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
        let controller = UIAlertController(title: NSLocalizedString("attention_alert_tile", comment: ""), message: "\(error)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        controller.addAction(action)
        controller.present(controller, animated: true, completion: nil)
    }
    
    public static func cityAlreadySaved(_ viewController: UIViewController, completion: @escaping () -> ()){
        let controller = UIAlertController(title: NSLocalizedString("attention_alert_tile", comment: ""), message: NSLocalizedString("alert_message_city_already_saved", comment: ""), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            completion()
        }
        controller.addAction(action)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    public static func limitBeenOver(_ viewController: UIViewController){
        let controller = UIAlertController(title: NSLocalizedString("attention_alert_tile", comment: ""), message: NSLocalizedString("alert_message_limit_been_over", comment: ""), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        controller.addAction(action)
        viewController.present(controller, animated: true, completion: nil)
    }
}
