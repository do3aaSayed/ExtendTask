//
//  ReositoryViewModel.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation
import UIKit

enum ResponseResult {
    case success(response: [Repository])
    case failure(error: APIError)
}

class RepositoryViewModel {
    
    var networkManager = NetworkManager()
    let decoder = JSONDecoder()
    
    func getAllPublicRepositories(completion: @escaping (ResponseResult) -> Void) {
        networkManager.request(withUrl: URL(string: Constants.allReposURL)!) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    if let data = data as? Data,let reposResponse = try self?.decoder.decode([Repository].self, from: data ) {
                        completion(.success(response: reposResponse))
                    } else {
                        completion(.failure(error: .parseError(StringConstants.decodingFailureMessage)))
                    }
                } catch {
                    completion(.failure(error: .invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error: .serverError(error.localizedDescription)))
            }
        }
    }
    
    func getRepoOwnerImage(url : URL,repo: Repository, completion: @escaping (UIImage?) -> Void) {
        networkManager.request(withUrl: url) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let data = data as? Data {
                        repo.image = UIImage(data: data)
                        completion(repo.image)
                    } else {
                      completion(nil)
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
