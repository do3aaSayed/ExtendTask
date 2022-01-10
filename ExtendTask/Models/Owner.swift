//
//  Owner.swift
//  ExtendTask
//
//  Created by mac on 09/01/2022.
//

import Foundation

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
    }
}
