//
//  Operation.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

/// Protocol to be implemented by all API operations to execute the request dispatcher to get the decoded model as response
protocol Operation {
    associatedtype DecodedModel
    var request: Request { get }

    func execute(in dispatcher: RequestDispatcher,
                 success: @escaping (DecodedModel) -> Void,
                 failure: @escaping (NetworkError) -> Void) throws
}
