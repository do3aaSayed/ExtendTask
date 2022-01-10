//
//  RepositoryViewController.swift
//  ExtendTask
//
//  Created by mac on 07/01/2022.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var branchesNamesLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    //MARK:- Variables
    var selectedRepository : Repository!
    var repoViewModel : RepositoryDetailsViewModel!
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repoViewModel = RepositoryDetailsViewModel(repo: selectedRepository)
        self.title = repoViewModel.fullName
        setViewValues(repoViewModel: repoViewModel)
    }
    
    //MARK:- Helper funcs
    func setViewValues(repoViewModel: RepositoryDetailsViewModel) {
        repoNameLabel.text = repoViewModel.name
        repoDescriptionLabel.text = repoViewModel.description
        ownerNameLabel.text = repoViewModel.owner?.login
        ownerAvatarImageView.image = repoViewModel.image ?? #imageLiteral(resourceName: "github")
        repoViewModel.getRepoBranches(url: repoViewModel.branchesURL ?? "", completion: { branches in
            DispatchQueue.main.async {
                self.branchesNamesLabel.text = branches.compactMap{$0.name}.joined(separator: "\n")
            }
        })
    }
}
