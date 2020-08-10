//
//  PreferredTableViewCell.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class PreferredTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var sfondo: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
