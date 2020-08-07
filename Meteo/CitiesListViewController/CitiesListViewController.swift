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
                controller.delegate?.locationDidChange(sender as! CitiesList)
            }
        }
    }


    
}

//MARK: - UITableVIewDelegate

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var result: CitiesList?
        
        if let citiesResult = citiesResult {
            result = citiesResult[indexPath.row]
            
        } else {
            result = citiesArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "ShowToMain", sender: result)
    }
}

//MARK: - UISearchBarDelegate

extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesResult = citiesArray.filter { $0.name.prefix(searchText.count) == searchText}
        dataSource? = CitiesListDataSource(cities: citiesResult ?? [])
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}
