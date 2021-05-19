//
//  PreferredWeatherViewController.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Lottie
import RealmSwift

//protocol SetupPreferedWeatherAfterFetching: class {
//    func setupUI(_ weather: [MainWeather])
//}
//
//
//class PreferredWeatherViewController: UIViewController, Storyboarded {
//    
//    //MARK: - Outlets
//    
//    @IBOutlet weak var progressLabel: UILabel! {
//        didSet {
//            progressLabel.text = NSLocalizedString("cities_progress_bar_label_text", comment: "")
//        }
//    }
//    
//    @IBOutlet weak var progressSave: UIProgressView!
//    
//    @IBOutlet weak var lottieContainer: UIView!
//    
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            tableView.backgroundColor = .clear
//        }
//    }
//    
//    @IBOutlet weak var backgroundImage: UIImageView!
//    
//    
//    //MARK: - Properties
//    var delegate: SetupPreferedWeatherAfterFetching?
//    private var loadingView = AnimationView()
//    var coordinator: MainCoordinator?
//    var progress = Progress(totalUnitCount: 10)
//    var dataSource: PreferredDataSource?
//    
//    var state: State = .loading {
//        didSet {
//            switch state {
//            case .loading:
//                navigationController?.navigationBar.isHidden = true
//                tableView.isHidden = true
//                progressLabel.isHidden = true
//                progressSave.isHidden = true
//                backgroundImage.isHidden = true
//                lottieContainer.isHidden = false
//                let animation = Animation.named("loading")
//                setupAnimation(for: animation!)
//            case .preparing:
//                navigationController?.navigationBar.isHidden = false
//                tableView.isHidden = false
//                progressSave.isHidden = false
//                progressLabel.isHidden = false
//                backgroundImage.isHidden = false
//                lottieContainer.isHidden = true
//                loadingView.stop()
//            }
//        }
//    }
//    
//
//    
////    var fetchManger = WeatherFetchManager()
//    
//    //MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if #available(iOS 13.0, *) {
//            // Always adopt a light interface style.
//            overrideUserInterfaceStyle = .light
//        }
//        
//        guard let weathers = coordinator?.savedWeathers else {
//            coordinator?.popViewController()
//            return
//        }
//        
//        state = .loading
//        self.delegate = self
//        self.delegate?.setupUI(weathers)
//
//        let leftButton = UIBarButtonItem(image: UIImage(named: "new_back"), style: .plain, target: self, action: #selector(cancelTapped(_:)))
//        navigationItem.leftBarButtonItem = leftButton
//        
//        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
//        tableView.delegate = self
//        let footerView = UIView()
//        footerView.backgroundColor = .red
//        tableView.tableFooterView = footerView
//        
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = .clear
//    }
//    
//    
//    
//    //MARK: - Actions
//    
//    
//    @objc func cancelTapped(_ sender: UIBarButtonItem) {
//        coordinator?.provenience = .preferedViewController
//        coordinator?.popViewController()
//    }
//    
//    
//    func setupAnimation(for animation: Animation) {
//        loadingView.frame = animation.bounds
//        loadingView.animation = animation
//        loadingView.contentMode = .scaleAspectFill
//        lottieContainer.addSubview(loadingView)
//        loadingView.backgroundBehavior = .pauseAndRestore
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        loadingView.topAnchor.constraint(equalTo: lottieContainer.topAnchor).isActive = true
//        loadingView.bottomAnchor.constraint(equalTo: lottieContainer.bottomAnchor).isActive = true
//        loadingView.trailingAnchor.constraint(equalTo: lottieContainer.trailingAnchor).isActive = true
//        loadingView.leadingAnchor.constraint(equalTo: lottieContainer.leadingAnchor).isActive = true
//        self.loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
//    }
//    
//    func setupNavigationBarColor(_ condition: MainWeather.WeatherCondition) {
//        
//        switch condition {
//        case .tempesta:
//            progressLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .pioggia:
//            progressLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .pioggiaLeggera:
//            progressLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .neve:
//            progressLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        case .nebbia:
//            progressLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .sole:
//            progressLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        case .nuvole:
//            progressLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        }
//    }
//    
//    
//    func setCurrentProgress(_ progressDone: Int) {
//        progress.completedUnitCount = Int64(progressDone)
//        let progressFloat = Float(progress.fractionCompleted)
//        progressSave.setProgress(progressFloat, animated: true)
//    }
//    
//}
//
//
////MARK: - UITableViewDelegate
//
//extension PreferredWeatherViewController: UITableViewDelegate{
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
//
//    private func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let configuration = UISwipeActionsConfiguration(actions: [self.removePreferredWeather(forRowAt: indexPath)])
//        configuration.performsFirstActionWithFullSwipe = false
//        
//        return configuration
//    }
//    
//    func removePreferredWeather(forRowAt indexPath: IndexPath)-> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "") { (contextualAction: UIContextualAction, view : UIView,completion: (Bool) -> Void) in
//            
//            self.state = .loading
//            
//            let selectedCity = self.coordinator?.savedWeathers[indexPath.row].name
//            
//            let filteredWeathers = self.coordinator?.savedWeathers.filter { $0.name != selectedCity }
//            
//            self.coordinator?.savedWeathers = filteredWeathers!
//            self.coordinator?.realmManagerCount = (filteredWeathers?.count)!
//            let realmManager = RealmManager()
//            realmManager.deleteWeather(selectedCity!)
//            
//            if filteredWeathers?.count == 0 {
//                self.coordinator?.provenience = .preferedViewController
//                self.coordinator?.popViewController()
//            } else {
//                self.delegate?.setupUI((filteredWeathers)!)
//            }
//        }
//        
//        action.image = UIImage(named: "i_Elimina")
//        action.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        return action
//    }
//    
//}
//
//
//
//extension PreferredWeatherViewController: SetupPreferedWeatherAfterFetching {
//    func setupUI(_ weather: [MainWeather]) {
//        self.dataSource = PreferredDataSource(weatherManager: weather)
//        self.tableView.dataSource = self.dataSource
//        self.backgroundImage.image = dataSource?.imageNavigationBar()
//        self.setupNavigationBarColor((dataSource?.conditionForNavigationBar())!)
//        self.tableView.reloadData()
//        self.setCurrentProgress(weather.count)
//        self.state = .preparing
//        
//    }
//}
//
//
//extension PreferredWeatherViewController {
//    enum State {
//        case loading
//        case preparing
//    }
//}
