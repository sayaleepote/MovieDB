//
//  RequestDispatcher.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

protocol RequestDispatcherProtocol {
    init(environment: Environment)
    
    /// This function executes the request and returns the raw API response encapsulated  in Response enum
    func execute(request: Request, completion: @escaping (Response) -> Void) throws
}

/// The dispatcher is responsible to execute a Request by calling URLSession and as output it will provide the Response object
class RequestDispatcher: RequestDispatcherProtocol {
    
    private var environment: Environment
    private var session: URLSession
    
    required init(environment: Environment) {
        self.environment = environment
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func execute(request: Request, completion: @escaping (Response) -> Void) throws {
        let request = try self.getURLRequest(for: request)
        let task = executeTask(with: request) { (response) in
            completion(response)
        }
        task.resume()
    }
    
    // MARK: - Private Methods
    private func getURLRequest(for request: Request) throws -> URLRequest {
        // Compose URL Request
        let endpoint = "\(environment.base)\(request.path)"
        guard let url = URL(string: endpoint) else { throw  NetworkError.invalidEndpoint }
        var urlRequest = URLRequest(url: url)
        
        // Add HTTP method
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        // Add Request Parameters
        switch request.requestParameterType {
        case .body(let bodyParams):
            if let bodyParams = bodyParams as? [String: String] {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: .fragmentsAllowed)
            } else {
                throw NetworkError.invalidRequestParameters
            }
        case .queryParameter(let queryParams):
            if let queryParams = queryParams as? [String: String] {
                let urlQueryItems = queryParams.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                guard var components = URLComponents(string: endpoint) else {
                    throw NetworkError.invalidRequestParameters
                }
                components.queryItems = urlQueryItems
                urlRequest.url = components.url
            } else {
                throw NetworkError.invalidRequestParameters
            }
        case .none:
            break
        }
        
        // Add headers from environment and request
        environment.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
    
    private func executeTask(with request: URLRequest,
                             completion: @escaping (Response) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(Response((data: data, urlResponse: response, error: error)))
        }
        return task
    }
}
