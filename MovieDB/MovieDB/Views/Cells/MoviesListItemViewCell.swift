//
//  MoviesListItemViewCell.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit

class MoviesListItemViewCell: UITableViewCell {
    
    private var viewModel: MovieListItemViewModel = MovieListItemViewModel()

    // MARK: - IBoutlets
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Setup
    func setupMovieCell(movie: Movie) {
        movieNameLabel.text = movie.title
    }
}
