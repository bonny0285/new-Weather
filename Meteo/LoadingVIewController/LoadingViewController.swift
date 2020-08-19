//
//  LoadingViewController.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 05/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var mainHeaderLabel: UILabel! {
        didSet {
            mainHeaderLabel.text = NSLocalizedString("loading_controller_main_text", comment: "")
        }
    }
    @IBOutlet weak var subHeaderLabel: UILabel! {
        didSet {
            subHeaderLabel.text = NSLocalizedString("loading_controller_sub_text", comment: "")
        }
    }
    @IBOutlet weak var loading: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
        overrideUserInterfaceStyle = .light
        }
        loading.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
        overrideUserInterfaceStyle = .light
        }
        loading.startAnimating()
    }
    
    


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loading.stopAnimating()
    }


}
