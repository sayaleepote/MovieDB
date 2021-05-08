//
//  Request.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// Protocol to build a request with all the necessary request parameters
protocol Request {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var requestParameterType: RequestParameterType? { get }
}

// MARK: - Headers
typealias HTTPHeaders = [String: String]

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
    case head       = "HEAD"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case options    = "OPTIONS"
}

// MARK: - RequestParameterType
enum RequestParameterType {
    case body(_ : [String: Any]?)
    case queryParameter(_ : [String: Any]?)
}
