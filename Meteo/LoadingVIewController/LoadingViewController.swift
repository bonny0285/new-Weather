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
    @IBOutlet weak var mainHeaderLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loading.stopAnimating()
    }


}
