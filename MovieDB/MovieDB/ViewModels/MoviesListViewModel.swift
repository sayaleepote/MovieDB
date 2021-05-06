//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import Foundation
import Kingfisher

/// ViewModel for movies list view
class MoviesListViewModel {
    
    private var moviesList = [Movie]()
    weak var delegate: MoviesListViewModelDelegate?
    
    func loadData() {
        delegate?.activityIndicator(isShown: true)
        let urlString = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"

        self.downloadJson(from: urlString) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.setMoviesList(from: data)
                self?.delegate?.reloadMoviesList()
            case .failure(let error):
                debugPrint("Unable to download json from the url: \(error)")
            }
            self?.delegate?.activityIndicator(isShown: false)
        }
    }
    
    func refreshData() {
        KingfisherManager.shared.cache.clearCache()
        loadData()
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
    
    func downloadJson(from urlString: String,
                              completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let data = data {
                    completion(.success(data))
                }
                if let error = error {
                    completion(.failure(error))
                }
            }
            urlSession.resume()
        }
    }
    
    func setMoviesList(from jsonData: Data) {
        do {
            let decodedJson = try JSONDecoder().decode(MovieArray.self,
                                                       from: jsonData)
            self.moviesList = decodedJson.movies
        } catch {
            debugPrint("Unable to decode movies list from the json data: \(error)")
        }
    }
}
