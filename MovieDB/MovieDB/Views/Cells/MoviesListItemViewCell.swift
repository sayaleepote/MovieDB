//
//  MoviesListItemViewCell.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit
import Kingfisher

class MoviesListItemViewCell: UITableViewCell {
    
    // MARK: - Constants
    struct Constants {
        static let placeholderImageName = "imagePlaceholder"
    }
    
    // MARK: - Properties
    private var viewModel: MovieDetailsViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Setup
    func setupMovieCell(movie: Movie) {
        viewModel = MovieDetailsViewModel(movie: movie)
        
        movieNameLabel.text = viewModel?.getMovieTitle()
        if let movieImageURL = viewModel?.getMovieImageURL() {
            movieImageView.kf.setImage(with: movieImageURL)
        } else {
            movieImageView.image = UIImage(named: Constants.placeholderImageName)
        }
    }
}
