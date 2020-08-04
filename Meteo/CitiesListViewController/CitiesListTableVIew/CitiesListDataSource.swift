//
//  CitiesListDataSource.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 03/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class CitiesListDataSource: NSObject {
    
    var citiesList: [CitiesList]
    var organizer: DataOrganizer
    
    init(cities: [CitiesList]) {
        self.citiesList = cities
        self.organizer = DataOrganizer(cities: cities)
    }
}


extension CitiesListDataSource {
    
    struct DataOrganizer {
        
        var citiesList: [CitiesList]
        
        var citiesCounting: Int {
            citiesList.count
        }
        
        init(cities: [CitiesList]) {
            self.citiesList = cities
        }
        
        func getCity(at index: IndexPath) -> CitiesList{
            citiesList[index.row]
        }
    }
}


extension CitiesListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        organizer.citiesCounting
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CitiesListTableViewCell else {
            return UITableViewCell()
        }
        
        let city = organizer.getCity(at: indexPath)
        
        cell.configureAtRow(city)
        
        return cell
    }
}


extension CitiesListTableViewCell {
    
    func configureAtRow(_ city: CitiesList) {
        self.cityLabel.text = city.name
        self.stateLabel.text = city.country
    }
}
