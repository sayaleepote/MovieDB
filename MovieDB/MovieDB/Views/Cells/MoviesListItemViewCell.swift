//
//  MoviesListItemViewCell.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit
import Kingfisher

class MoviesListItemViewCell: UITableViewCell {

    // MARK: - IBoutlets
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Setup
    func setupMovieCell(movie: Movie) {
        movieNameLabel.text = movie.title
        if let movieImageURL = movie.imageHref,
           let url = URL(string: movieImageURL) {
            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = UIImage(named: "imagePlaceholder")
        }
    }
}
