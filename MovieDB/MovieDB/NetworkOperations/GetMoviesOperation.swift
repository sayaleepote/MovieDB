//
//  GetMovies.swift
//  MovieDB
//
//  Created by Sayalee Pote on 08/05/21.
//

import Foundation

class GetMoviesOperation<Movies>: Operation {
    
    var request: Request {
        return MovieDBRequest.getMovies
    }
    
    func execute(in dispatcher: RequestDispatcher,
                 success: @escaping ([Movie]) -> Void,
                 failure: @escaping (NetworkError) -> Void) throws {
        try dispatcher.execute(request: request, completion: { response in
            switch response {
            case .data(let data):
                do {
                    let moviesArray = try self.decodeJson(jsonData: data)
                    success(moviesArray)
                } catch {
                    failure(error as! NetworkError)
                }
            case .error(let error):
                failure(error)
            }
        })
    }
    
    // MARK: - Private methods
    private func decodeJson(jsonData: Data) throws -> [Movie] {
        do {
            let decodedJson = try JSONDecoder().decode(MovieArray.self, from: jsonData)
            return decodedJson.movies
        } catch {
            throw NetworkError.jsonDecodingFailed
        }
    }
}
