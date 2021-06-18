//
//  WeatherMiddleView.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 21/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class WeatherMiddleView: UIView {

    //MARK: - Outlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundWeatherImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    //MARK: - Properties

    var viewModel: ViewModel! {
        didSet {
            backgroundWeatherImage.image = viewModel.weatherImage
            timeLabel.text = viewModel.weatherTime
            descriptionLabel.text = viewModel.weatherDescription
            tempMaxLabel.text = viewModel.tempMax
            tempMinLabel.text = viewModel.tempMin
        }
    }
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Methods

    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherMiddleView", owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension WeatherMiddleView {
    struct ViewModel {
        let weatherImage: UIImage
        let weatherTime: String
        let weatherDescription: String
        let tempMax: String
        let tempMin: String
    }
}
