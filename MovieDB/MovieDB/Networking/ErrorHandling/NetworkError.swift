//
//  NetworkError.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// Custom error for network layer
enum NetworkError: Error {
    case invalidEndpoint
    case invalidRequestParameters
    case invalidURLResponse
    case invalidResponseData
    case requestFailed
    case jsonDecodingFailed
    
    var localizedDescription: String {
        switch self {
        case .invalidEndpoint: return
            "Invalid endpoint sent to request dispatcher"
        case .invalidRequestParameters: return
            "Invalid request parameter sent to request dispatcher"
        case .invalidURLResponse: return
            "Invalid urlResponse received from the server"
        case .invalidResponseData: return
            "Invalid data received from the server response"
        case .requestFailed: return
            "Rest Request failed"
        case .jsonDecodingFailed: return
            "Failed to decode the json from data"
        }
    }
}
