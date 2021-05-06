//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let moviesListItemCellIdentifier = "MoviesListItemViewCell"
        static let storyBoardName = "Main"
        static let movieDetailsViewController = "MovieDetailsViewController"
    }
    
    // MARK: - Properties
    private let viewModel: MoviesListViewModel
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - init
    required init?(coder: NSCoder) {
        viewModel = MoviesListViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        setupView()
    }
    
    func setupView() {
        self.title = "MoviesList.Title".localized()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.moviesListItemCellIdentifier, for: indexPath) as? MoviesListItemViewCell {
            let movie = viewModel.getMovie(at: indexPath.row)
            cell.setupMovieCell(movie: movie)
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK:- UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: Constants.storyBoardName,
                                               bundle: nil)
        if let movieDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.movieDetailsViewController) as? MovieDetailsViewController {
            let selectedMovie = viewModel.getMovie(at: indexPath.row)
            movieDetailsViewController.setupViewModel(movie: selectedMovie)
            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
    }
}

