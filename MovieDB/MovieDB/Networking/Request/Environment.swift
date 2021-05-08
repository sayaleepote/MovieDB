//
//  Environment.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// This struct encapsulates all the informations required to setup a environment for a request dispatcher
public struct Environment {
    var name: String
    var base: String
    var headers: HTTPHeaders = [:]
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public init(name: String, base: String) {
        self.name = name
        self.base = base
    }
}
