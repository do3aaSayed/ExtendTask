//
//  NetworkManager.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request(withUrl url: URL, completion: @escaping (Result<Any,Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            NetworkResponseHandler.shared.handleDataTaskResponse(data: data, urlResponse: response, error: error) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        task.resume()
    }
}
