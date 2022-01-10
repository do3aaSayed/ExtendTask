//
//  RepositoryDetailsViewModel.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation
import UIKit

class RepositoryDetailsViewModel {
    var name, fullName: String?
    var owner: Owner?
    var image: UIImage?
    var description: String?
    var branchesURL : String?
    var branches: [Branch] = []
    let decoder = JSONDecoder()
    
    init(repo: Repository) {
        self.name = repo.name
        self.fullName = repo.fullName
        self.owner = repo.owner
        self.image = repo.image
        self.description = repo.description
        self.branchesURL = repo.branchesURL.replacingOccurrences(of: "{/branch}", with: "")
    }
    
    func getRepoBranches(url: String, completion: @escaping ([Branch]) -> Void) {
        if let url = URL(string: url) {
            NetworkManager.shared.request(withUrl: url) { result in
                switch result {
                case .success(let data):
                    do {
                        if let data = data as? Data{
                            let branches = try self.decoder.decode([Branch].self, from: data)
                            completion(branches)
                        }
                    } catch {
                        completion([])
                    }
                case .failure(let error):
                    completion([])
                }
            }
        } else {
            completion([])
        }
    }
}
