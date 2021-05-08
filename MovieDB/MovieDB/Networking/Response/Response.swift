//
//  Response.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// Response enum returns data or error based on the API response
enum Response {
    case data(_: Data)
    case error(_: NetworkError)
    
    init(_ response: (data: Data?, urlResponse: URLResponse?, error: Error?)) {
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            self = .error(NetworkError.invalidURLResponse)
            return
        }
        
        guard httpResponse.statusCode == 200, response.error == nil else {
            self = .error(NetworkError.requestFailed)
            return
        }
        
        guard let data = response.data else {
            self = .error(NetworkError.invalidResponseData)
            return
        }
        self = .data(data)
    }
}
