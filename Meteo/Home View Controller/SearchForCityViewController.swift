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

class SearchForCityViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties

    let viewModel = SearchForCityViewModel()
    private var cancelBag = Set<AnyCancellable>()
    private var lottieContainer = UIView()
    private var loadingView = AnimationView()
    private lazy var dataSource = configureDataSource()
    private var cityContainer: [CitiesList] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SearchForCityViewController"
        
        let animation = Animation.named("loading")
        setupAnimation(animation)
        
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self, let result = result else { return }
                print("RESULT: \(result.count)")
                self.cityContainer = result
                    .filter { $0.name != "" }
                    .filter { $0.name.starts(with: "-") == false }
                    .filter { $0.name.starts(with: "(") == false }
                    .filter { $0.name.starts(with: "'") == false }
                
                self.setupTableView()
                self.lottieContainer.removeFromSuperview()
                self.loadingView.stop()
            }
            .store(in: &cancelBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }
    

    //MARK: - Methods

    private func setupAnimation(_ animation: Animation?) {
        guard let animation = animation else { return }
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
    
    private func setupTableView() {
        let nib = UINib(nibName: "MenuCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "MenuCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = dataSource
        snapshotDataSource()
    }
    
    
    //MARK: - Actions


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

    private func snapshotDataSource() {
        //let optionsContainer = MenuOptions.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, CitiesList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cityContainer)
        dataSource.apply(snapshot)
    }
}
