//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import Foundation

/// View model for views that need movie related information
class MovieDetailsViewModel {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieTitle() -> String? {
        return movie.title
    }
    
    func getMovieImageURL() -> URL? {
        if let movieImageURL = movie.imageHref,
           let url = URL(string: movieImageURL) {
            return url
        }
        return nil
    }
    
    func getMovieReleaseDateString() -> String? {
        guard let releaseDate = movie.releaseDate else { return nil }
        return "MovieDetails.ReleaseDate".localized() + ": " + releaseDate
    }
    
    func getMovieRatingString() -> String? {
        guard let rating = movie.rating else { return nil }
        return "MovieDetails.Rating".localized() + ": " + String(rating)
    }
}
