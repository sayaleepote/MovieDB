//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import Foundation

/// ViewModel for movies list view
class MoviesListViewModel {
    
    private var moviesList = [Movie]()
    
    func loadData() {
        if let moviesJsonData = self.readJson(from: "movies") {
            self.setMoviesList(from: moviesJsonData)
        }
    }
    
    func getMovieCount() -> Int {
        return moviesList.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return moviesList[index]
    }
}

// MARK: - Private Methods
private extension MoviesListViewModel {
    func readJson(from fileName: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            debugPrint("Unable to read json data from file: \(error)")
            return nil
        }
        
        return nil
    }
    
    func setMoviesList(from jsonData: Data) {
        do {
            let decodedJson = try JSONDecoder().decode(DecodedArray.self,
                                                       from: jsonData)
            self.moviesList = decodedJson.movies
        } catch {
            debugPrint("Unable to decode movies list from the json data: \(error)")
        }
    }
}
