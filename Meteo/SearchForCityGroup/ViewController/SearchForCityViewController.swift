//
//  SearchForCityViewController.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 25/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import Combine
import RealmSwift

class SearchForCityViewController: BaseViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    let viewModel = SearchForCityViewModel()
    private var cancelBag = Set<AnyCancellable>()
    private lazy var dataSource = configureDataSource()
    private var cityContainer: [CityBulk] = []
    private let databaseRepository = DatabaseRepository()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SearchForCityViewController"
        textField.delegate = self
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - Methods
    
    private func setupTableView() {
        let nib = UINib(nibName: "MenuCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "MenuCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
    
    
    //MARK: - Actions
    
    @IBAction func textFieldEditingDidChange(_ sender: UITextField) {
        super.animationIsNeeded = true
        
        let text = sender.text?.uppercasedFirst ?? ""
        
        if cityContainer.count == 0, text.isEmpty == false {
            
            databaseRepository.retriveAllDictByLetter(text) { [weak self] cities in
                guard let self = self, let cities = cities else { return }

                self.cityContainer = Array(cities).filter { $0.name.contains(text) }
                self.snapshotDataSource(self.cityContainer)
            }
            
        } else if text.isEmpty == false, cityContainer.count > 0 {
            
            let filtered = cityContainer.filter { $0.name.starts(with: text) }
            snapshotDataSource(filtered)
            
        } else if text.isEmpty {
            cityContainer.removeAll()
            snapshotDataSource(cityContainer)
        }
    }
}

extension SearchForCityViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
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
        print("UUID: \(city.id)")
        //delegate?.sideMenuDidPressOption(option)
    }
    
    private func configureDataSource() -> UITableViewDiffableDataSource<Section, CityBulk> {
        return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, city) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "MenuCell",
                for: indexPath
            ) as! MenuCell
            
            cell.configureWithTitleAndSubTitle(city.name, city.country)
            
            return cell
        }
    }
    
    
    
    private func snapshotDataSource(_ data: [CityBulk]) {
        //let optionsContainer = MenuOptions.allCases
        print("SnapshotData: \(data.count)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, CityBulk>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        snapshot.reloadItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        super.animationIsNeeded = false
    }
    
    private func snapshotDataSource(_ data: List<CityBulk>) {
        //let optionsContainer = MenuOptions.allCases
        print("SnapshotData: \(data.count)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, CityBulk>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data.map { $0 })
        snapshot.reloadItems(data.map { $0 })
        
        dataSource.apply(snapshot, animatingDifferences: false)
        super.animationIsNeeded = false
    }
}



