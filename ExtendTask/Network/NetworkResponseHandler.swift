//
//  NetworkResponseHandler.swift
//  ExtendTask
//
//  Created by mac on 10/01/2022.
//

import Foundation

enum APIError: Error {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

protocol NetworkResponserHandlerProtocol {
    func handleDataTaskResponse(data: Data?,urlResponse: URLResponse?, error: Error?,completion: (Result<Any,Error>) -> Void)
    func handleDownloadTaskResponse(fileUrl: URL?, urlResponse: URLResponse?, error: Error?,completion: (Result<Any,Error>) -> Void)
}

class NetworkResponseHandler : NetworkResponserHandlerProtocol {

    static var shared = NetworkResponseHandler()
    
    func handleDataTaskResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: (Result<Any, Error>) -> Void) {
        let result = verifyResponse(withResponse: urlResponse, data: data, error: error)
        switch result {
        case .success(let data):
            let parseResult = parseDataResponse(data: data as? Data)
            completion(parseResult)
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func handleDownloadTaskResponse(fileUrl: URL?, urlResponse: URLResponse?, error: Error?, completion: (Result<Any, Error>) -> Void) {
        let result = verifyResponse(withResponse: urlResponse, data: fileUrl, error: error)
        switch result {
        case .success(let url):
            completion(.success(url))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func verifyResponse(withResponse response: URLResponse?,data: Any?,error : Error?) -> Result<Any, Error> {
        guard let httpUrlResponse = response as? HTTPURLResponse else {
            return .failure(APIError.invalidResponse)
        }
        switch httpUrlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(APIError.noData)
            }
        case 400...499:
            return .failure(APIError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(APIError.serverError(error?.localizedDescription))
        default:
            return .failure(APIError.unknown)
        }
    }
    
    private func parseDataResponse(data: Data?) -> Result<Any, Error> {
        guard let data = data else {
            return .failure(APIError.invalidResponse)
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return .success(json)
        } catch (let exception) {
            return .failure(APIError.parseError(exception.localizedDescription))
        }
    }
}
