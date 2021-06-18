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
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureWhitTitle(_ title: String) {
        titleLabel.text = title
        subTitleLabel.isHidden = true
    }
    
    func configureWithTitleAndSubTitle(_ title: String, _ subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
