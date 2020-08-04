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
    @IBOutlet weak var headerLabel: UILabel!
    
    
    //MARK: - Properies

    var citiesResult: [CitiesList]?
    var dataSource: CitiesListDataSource?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = "Result for: \(citiesResult?[0].name ?? "")" 
        
        let nib = UINib(nibName: "CitiesListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cityCell")
        
        dataSource = CitiesListDataSource(cities: citiesResult ?? [])
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
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

    
}

//MARK: - UITableVIewDelegate

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityToSendBack = citiesResult![indexPath.row]
        performSegue(withIdentifier: "ShowToMain", sender: cityToSendBack)
    }
}
