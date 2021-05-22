//
//  MenuCell.swift
//  Meteo
//
//  Created by Massimiliano on 22/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configureWhit(_ title: String) {
        titleLabel.text = title
    }
    
}
