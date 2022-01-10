//
//  ReositoriesResponseViewModel.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation

enum ResponseResult {
    case success(response: RepositoriesResponse)
    case failure(error: APIError)
}

class RepositoriesResponseViewModel {
    
    var networkWorker = NetworkManager()
    let decoder = JSONDecoder()
    
    func getAllPublicRepositories(completion: @escaping (ResponseResult) -> Void) {
        networkWorker.request(withUrl: URL(string: Constants.allReposURL)!, type: .data) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    if let reposResponse = try self?.decoder.decode(RepositoriesResponse.self, from: data as! Data) {
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
}
