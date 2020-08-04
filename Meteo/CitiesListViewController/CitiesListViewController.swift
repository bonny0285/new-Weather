//
//  CitiesListViewController.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    
    //MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Properies

    var citiesResult: [CitiesList]?
    var dataSource: CitiesListDataSource?
    var citiesArray: [CitiesList] = []
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let nib = UINib(nibName: "CitiesListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cityCell")
        
        fetchCities()
        
        dataSource = CitiesListDataSource(cities: citiesArray)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowToMain" {
            if let controller = segue.destination as? MainViewController {
                controller.getResult = sender as? CitiesList
            }
        }
    }

    
    
    
    func fetchCities() {
        citiesArray.removeAll()
        let file = Bundle.main.path(forResource: "cityList", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file!))
            let decoder = JSONDecoder()
            let result = try decoder.decode([CitiesList].self, from: data)
            
            citiesArray = result.sorted { $0.name < $1.name}.compactMap { $0 }
            debugPrint("Prima città",citiesArray[0].name)
            print("Prima città",citiesArray[0].name)
            tableView.reloadData()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
}

//MARK: - UITableVIewDelegate

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let citiesResult = citiesResult {
            performSegue(withIdentifier: "ShowToMain", sender: citiesResult[indexPath.row])
        } else {
            let cityToSendBack = citiesArray[indexPath.row]
            performSegue(withIdentifier: "ShowToMain", sender: cityToSendBack)
        }
        
    }
}


extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesResult = citiesArray.filter { $0.name.prefix(searchText.count) == searchText}
        dataSource? = CitiesListDataSource(cities: citiesResult ?? [])
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}
