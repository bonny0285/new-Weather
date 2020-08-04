//
//  CitiesListTableViewCell.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class CitiesListTableViewCell: UITableViewCell {

    @IBOutlet weak var sfondo: UIView!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var stateTitleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func commonInit() {
        self.addSubview(sfondo)
        sfondo.frame = self.bounds
        sfondo.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sfondo.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sfondo.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sfondo.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive =  true
    }
    
}
