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
    
    // MARK: - Constants
    struct Constants {
        static let environmentName = "debug"
        static let baseURL = "https://www.dropbox.com"
    }
    
    // MARK: - Properties
    private var moviesList = [Movie]()
    private let requestDispatcher = RequestDispatcher(environment: Environment(name: Constants.environmentName,
                                                                               base: Constants.baseURL))
    weak var delegate: MoviesListViewModelDelegate?
    
    // MARK: - Methods
    func loadData() {
        delegate?.activityIndicator(isShown: true)
        do {
            try GetMoviesOperation<[Movie]>().execute(in: requestDispatcher, success: { (moviesList) in
                self.moviesList = moviesList
                self.delegate?.reloadMoviesList()
                self.delegate?.activityIndicator(isShown: false)
            }, failure: { error in
                debugPrint(error)
                self.delegate?.activityIndicator(isShown: false)
            })
        } catch {
            delegate?.activityIndicator(isShown: false)
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
