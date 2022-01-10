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
    var repositories = [Repository]()
    var filteredRepos = [Repository]()
    var reposViewModel = RepositoryViewModel()
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        setUpTableDelegateAndDataSource()
        getRepositories()
    }
    
    //MARK:- Helper funcs
    func getRepositories(withNameContains name : String = "") {
        reposViewModel.getAllPublicRepositories { result in
            switch result {
            case .success(response: let repos):
                self.repositories = repos
                self.filteredRepos = repos
                self.tableView.reloadData()
            case .failure(error: let error):
                print(error)
            }
        }
    }
}

extension RepositoriesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredRepos = repositories
            tableView.reloadData()
            return
        }
        filteredRepos = repositories.filter({ repo in
            repo.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension RepositoriesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func setUpTableDelegateAndDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        cell.configureCell(repo: filteredRepos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

