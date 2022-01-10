//
//  RepositoriesResponse.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation

struct RepositoriesResponse: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case url
    }
}
