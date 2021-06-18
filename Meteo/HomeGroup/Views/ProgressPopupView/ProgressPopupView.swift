//
//  ProgressPopupView.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 17/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Combine

protocol ProgressPopupViewDelegate: AnyObject {
    func closeProgressPopupView()
}

class ProgressPopupView: UIView {
    
    //MARK: - Outlets

    private var progressView = UIProgressView()
    private let titleLabel = UILabel()
    private var confirmButton = UIButton()
    private var cancelButton = UIButton()
    
    //MARK: - Properties

    weak var delegate: ProgressPopupViewDelegate?
    private let viewModel = ProgressPopupViewViewModel()
    private var cancelBag = Set<AnyCancellable>()

//    init() {
//        super.init(frame: CGRect())
//        viewModel.$counter.sink { value in
//            print("Score: \(value)")
//          // DispatchQueue.main.async {
//                self.progressView.progressTintColor = .red
//                self.progressView.trackTintColor = .gray
//                self.progressView.progress = 0
//                let progress: Float = Float(value) / Float(209579)
//                self.progressView.progress = Float(value) / Float(209579)
//               //self.progressView.setProgress(progress, animated: true)
//
//       // }
//        }.store(in: &cancelBag)
//    }
    override init(frame: CGRect) { super.init(frame: frame) }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    //MARK: - Methods

    func configureWith(title: String) {
        titleLabel.text = title
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setTitle("CONFIRM", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .equalSpacing
        
        self.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        progressView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20).isActive = true
        progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupScoreOnProgressView(_ score: Int64) {
        DispatchQueue.main.async {
            let totalProgress = Progress(totalUnitCount: 209579)
            self.progressView.progress = 0.0
            totalProgress.completedUnitCount = 0
            self.progressView.tintColor = .blue
            self.progressView.progressTintColor = .blue
            self.progressView.trackTintColor = .gray
            totalProgress.completedUnitCount = Int64(score)
            let progressFloat = Float(totalProgress.fractionCompleted)
            self.progressView.setProgress(progressFloat, animated: true)
        }
    }
    
    @objc private func confirmButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.progressView.progressTintColor = .red
            self.progressView.trackTintColor = .gray
            self.progressView.progress = 10
            let progress: Float = Float(self.viewModel.score) / Float(209579)
            //self.progressView.progress = Float(self.viewModel.score) / Float(209579)
            self.progressView.setProgress(progress, animated: true)
        }
        


        

        self.viewModel.fetchCities { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let citiesList):
                print(citiesList.count)
//                let databaseRepository = DatabaseRepository()
//                databaseRepository.saveToDict(citiesList)
//                setSearchForFirstTime(true)
//                self.viewModel.delegate?.openSearchViewController()
                
            case .failure(let error):
                print("Error during download cities list: \(error)")
            }
        }
        //209579
        //29687564
    }
    
    @objc private func cancelButtonAction(_ sender: UIButton) {
        delegate?.closeProgressPopupView()
    }
}
