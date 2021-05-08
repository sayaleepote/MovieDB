//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let placeholderImageName = "imagePlaceholder"
    }
    
    // MARK: - Properties
    var viewModel: MovieDetailsViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupViewModel(movie: Movie) {
        self.viewModel = MovieDetailsViewModel(movie: movie)
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        movieTitle.text = viewModel?.getMovieTitle()
        movieReleaseDate.text = viewModel?.getMovieReleaseDateString()
        movieRating.text = viewModel?.getMovieRatingString()
        if let movieImageURL = viewModel?.getMovieImageURL() {
            movieImage.kf.setImage(with: movieImageURL)
        } else {
            movieImage.image = UIImage(named: Constants.placeholderImageName)
        }
    }
}
