//
//  RepositoryTableViewCell.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    
    private let repoViewModel = RepositoryViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(repo: Repository) {
        repoNameLabel.text = repo.name
        ownerNameLabel.text = repo.owner.login
        setupOwnerImage(repo: repo)
        
    }
    
    private func setupOwnerImage(repo : Repository) {
        if let image = repo.image {
            ownerAvatarImageView.image = image
        } else if let url = URL(string: repo.owner.avatarURL) {
            repoViewModel.getRepoOwnerImage(url: url, repo: repo) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.ownerAvatarImageView.image = image
                    } else {
                        self.ownerAvatarImageView.image = #imageLiteral(resourceName: "github")
                    }
                }
            }
        } else {
            self.ownerAvatarImageView.image = #imageLiteral(resourceName: "github")
        }
    }
}
