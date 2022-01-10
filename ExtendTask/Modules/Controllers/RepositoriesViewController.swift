//
//  ViewController.swift
//  ExtendTask
//
//  Created by mac on 06/01/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }
    
    //MARK:- Helper funcs
    func getRepositories(withNameContains name : String) {
        
    }
    
}

extension RepositoriesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getRepositories(withNameContains: searchText)
    }
}

