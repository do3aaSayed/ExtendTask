//
//  Repository.swift
//  ExtendTask
//
//  Created by mac on 09/01/2022.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let owner: Owner
    let description: String?
    let branchesURL: String
    let languagesURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case description
        case branchesURL = "branches_url"
        case languagesURL = "languages_url"
        case createdAt = "created_at"
    }
}
