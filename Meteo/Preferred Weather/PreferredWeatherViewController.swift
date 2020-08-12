//
//  PreferredWeatherViewController.swift
//  Meteo
//
//  Created by Massimiliano Bonafede on 09/08/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class PreferredWeatherViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties

    

    var dataSource: PreferredDataSource?
    var weatherManager: WeatherManager? {
        didSet {
           dataSource = PreferredDataSource(weatherManager: weatherManager!)
            
        }
    }

    
    var loadingController = UIViewController() {
        didSet {
            loadingController = UIStoryboard(name: "loading", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        title = NSLocalizedString("preferred_title", comment: "")
        
        let nib = UINib(nibName: "PreferredTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreferredTableViewCell")
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        tableView.reloadData()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.reloadData()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}


extension PreferredWeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    
    

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        if indexPath == tableView.indexPathForSelectedRow {
//            print("CI SIAMO")
//        }
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
//            print("index path of delete: \(indexPath)")
//            //completionHandler(true)
//        }
//
//        let swipeActionConfig = UISwipeActionsConfiguration(actions: [ delete])
//
//        swipeActionConfig.performsFirstActionWithFullSwipe = false
//        return swipeActionConfig
//    }




}




