//
//  MovieDBRequest.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// Application specific request maker enum where each request could be an enum case. In this usecase we only have one API call to get movies
enum MovieDBRequest: Request {
    case getMovies
    
    var path: String {
        switch self {
        case .getMovies:
            return "/s/q1ins5dsldsojzt/movies.json?dl=1"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMovies:
            return nil
        }
    }
    
    var requestParameterType: RequestParameterType? {
        switch self {
        case .getMovies:
            return nil
        }
    }
}
