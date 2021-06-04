//
//  SearchForCityViewController.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 25/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Lottie
import Combine

class SearchForCityViewController: BaseViewController {

    //MARK: - Outlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties

    let viewModel = SearchForCityViewModel()
    private var cancelBag = Set<AnyCancellable>()
//    private var lottieContainer = UIView()
//    private var loadingView = AnimationView()
    private lazy var dataSource = configureDataSource()
    private var cityContainer: [CitiesList] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SearchForCityViewController"
        textField.delegate = self
//        let animation = Animation.named("loading")
//        setupAnimation(animation)
        self.setupTableView()
        
        
//        viewModel.$cities
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] result in
//                guard let self = self, let result = result else { return }
//                print("RESULT: \(result.count)")
//                
//                self.cityContainer = result
//                    .filter {
//                        $0.name.isEmpty == false
//                        && $0.name.starts(with: "-") == false
//                        && $0.name.starts(with: "(") == false
//                        && $0.name.starts(with: "'") == false
//                    }
//                
//                self.snapshotDataSource(self.cityContainer)
//                self.lottieContainer.removeFromSuperview()
//                self.loadingView.stop()
//            }
//            .store(in: &cancelBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let databaseRepository = DatabaseRepository()
        databaseRepository.retriveAll { [weak self] result in
            guard let self = self, let result = result else { return }
            print(result.count)
        }
    }
    

    //MARK: - Methods

//    private func setupAnimation(_ animation: Animation?) {
//        guard let animation = animation else { return }
//        lottieContainer.backgroundColor = .white
//        loadingView.frame = animation.bounds
//        loadingView.animation = animation
//        loadingView.contentMode = .scaleAspectFill
//        loadingView.backgroundBehavior = .pauseAndRestore
//        ConstraintBuilder.setupAllEdgesConstrainFor(child: lottieContainer, into: self.view)
//        self.view.bringSubviewToFront(lottieContainer)
//        ConstraintBuilder.setupAllEdgesConstrainFor(child: loadingView, into: lottieContainer)
//        loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
//    }
    
    private func setupTableView() {
            let nib = UINib(nibName: "MenuCell", bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: "MenuCell")
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = dataSource
            //snapshotDataSource(cityContainer)
    }
    
    
    //MARK: - Actions

    @IBAction func textFieldEditingDidChange(_ sender: UITextField) {
        super.animationIsNeeded = true

//        if let text = sender.text, text.isEmpty == false {
//            
//            if self.cityContainer.count > 0 {
//                self.snapshotDataSource(self.cityContainer.filter { $0.name.starts(with: text) })
//                super.animationIsNeeded = false
//            } else {
//                self.viewModel.fetchBySearch(startWith: text) { result in
//                    self.cityContainer = result
//                    self.snapshotDataSource(result)
//                    super.animationIsNeeded = false
//                }
//            }
//            
//        } else {
//            self.cityContainer.removeAll()
//            self.snapshotDataSource(self.cityContainer)
//            super.animationIsNeeded = false
//        }
    }
}

extension SearchForCityViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
//        guard let text = textField.text else { return }
//        print("PASSATO: Text: \(text) - \(text.isEmpty == true)")
//        let filered = cityContainer.filter { $0.name.starts(with: text) }
//        print("Filtered: \(filered.count)")
//        let choise = text.isEmpty == true ? cityContainer : filered
//        print("Choise: \(choise.count)")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.snapshotDataSource(choise)
//        }
        
    }
}

extension SearchForCityViewController: UITableViewDelegate {
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 60
//        }
//
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let city = cityContainer[indexPath.row]
            print("City name: \(city.name)")
            print("City id: \(city.id)")
            print("City country: \(city.country)")
            print("UUID: \(city.reference)")
            //delegate?.sideMenuDidPressOption(option)
        }

    private func configureDataSource() -> UITableViewDiffableDataSource<Section, CitiesList> {
        return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, city) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "MenuCell",
                for: indexPath
            ) as? MenuCell
            
            cell?.configureWhit(city.name)
            return cell
        }
    }

    private func snapshotDataSource(_ data: [CitiesList]) {
        //let optionsContainer = MenuOptions.allCases
        print("SnapshotData: \(data.count)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, CitiesList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        snapshot.reloadItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


class BaseViewController: UIViewController {
    
    private var lottieContainer = UIView()
    private var loadingView = AnimationView()
    var animationIsNeeded: Bool = false {
        didSet {
            if animationIsNeeded {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.setupAnimation()
                }
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.loadingView.stop()
                    self.lottieContainer.removeFromSuperview()
                }
            }
        }
    }
    
    
    private func setupAnimation() {
        guard let animation = Animation.named("loading") else { return }
        lottieContainer.backgroundColor = .white
        loadingView.frame = animation.bounds
        loadingView.animation = animation
        loadingView.contentMode = .scaleAspectFill
        loadingView.backgroundBehavior = .pauseAndRestore
        ConstraintBuilder.setupAllEdgesConstrainFor(child: lottieContainer, into: self.view)
        self.view.bringSubviewToFront(lottieContainer)
        ConstraintBuilder.setupAllEdgesConstrainFor(child: loadingView, into: lottieContainer)
        loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
}
