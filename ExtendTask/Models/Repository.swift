//
//  Repository.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation
import UIKit

class Repository: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let url: String
    let owner: Owner
    var image: UIImage?
    let description: String?
    let branchesURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case url
        case owner
        case description
        case branchesURL = "branches_url"
    }
}
