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

    
    var cellAtIndexPath: Int = 0
    var dataSource: PreferredDataSource?
    var weatherManager: WeatherManagerModel? {
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
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        tableView.reloadData()
//    }
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
    
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let configuration = UISwipeActionsConfiguration(actions: [self.esauditoDesiderio(forRowAt: indexPath.row)])
            configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func esauditoDesiderio(forRowAt indexPath: Int)-> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Esaudito") { (contextualAction: UIContextualAction, view : UIView,completion: (Bool) -> Void) in
            
//            self.desiderio = Desiderio(testo: self.arrayDesideri[indexPath].testo, data: self.arrayDesideri[indexPath].data, ordine: self.arrayDesideri[indexPath].ordine)
//
//            guard let desiderio = self.desiderio else { return }
//            self.desideriEsauditi.append(desiderio)
//
//            self.deleteDesiderio(indexPath)
//
//            let data = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd'/'MM'/'yyyy'"
//            let date = dateFormatter.string(from: data)
//
//            DesideriDB.insertDesiderioEsaudito(forUser: self.currentUser!, desiderio: desiderio.testo, data: desiderio.data, ordine: desiderio.ordine, fine: date)
            
            //self.tableView.reloadData()
            print("DELETED")
        }
        
        action.backgroundColor = #colorLiteral(red: 1, green: 0.6682497973, blue: 0.339296782, alpha: 1)
        
        return action
    }

//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("DELETED")
//            //objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
////        if indexPath == tableView.indexPathForSelectedRow {
////            print("CI SIAMO")
////        }
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
//            print("index path of delete: \(indexPath)")
//            completionHandler(true)
//        }
//
//        let swipeActionConfig = UISwipeActionsConfiguration(actions: [ delete])
//
//        swipeActionConfig.performsFirstActionWithFullSwipe = false
//        return swipeActionConfig
//    }




}




