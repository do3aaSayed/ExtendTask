//
//  NetworkManager.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation

enum RequestType {
    case data
    case download
}

class NetworkManager {
    func request(withUrl url: URL, type : RequestType, completion: @escaping (Result<Any,Error>) -> Void) {
        let session = URLSession.shared
        switch type {
        case .data:
            session.dataTask(with: url) { data, response, error in
                NetworkResponseHandler.shared.handleDataTaskResponse(data: data, urlResponse: response, error: error) { result in
                    completion(result)
                }
            }
        case .download:
            session.downloadTask(with: url) { url, response, error in
                NetworkResponseHandler.shared.handleDownloadTaskResponse(fileUrl: url, urlResponse: response, error: error) { result in
                    completion(result)
                }
            }
        }
    }
}
