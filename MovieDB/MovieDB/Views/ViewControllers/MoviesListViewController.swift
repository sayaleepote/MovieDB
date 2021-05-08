//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit

protocol MoviesListViewModelDelegate: class {
    func activityIndicator(isShown: Bool)
    func reloadMoviesList()
}

class MoviesListViewController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let moviesListItemCellIdentifier = "MoviesListItemViewCell"
        static let storyBoardName = "Main"
        static let movieDetailsViewController = "MovieDetailsViewController"
    }
    
    // MARK: - Properties
    private let viewModel: MoviesListViewModel
    private let refreshControl = UIRefreshControl()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - init
    required init?(coder: NSCoder) {
        viewModel = MoviesListViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        setupView()
    }
    
    // MARK: - Private setup methods
    private func loadMovies() {
        viewModel.delegate = self
        viewModel.loadData()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "MoviesList.Title".localized()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        // Add refresh control to table view
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMoviesList(_:)), for: .valueChanged)
    }
    
    @objc private func refreshMoviesList(_ sender: Any) {
        viewModel.refreshData()
        refreshControl.endRefreshing()
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

// MARK: - MoviesListViewModelDelegate
extension MoviesListViewController: MoviesListViewModelDelegate {
    func activityIndicator(isShown: Bool) {
        DispatchQueue.main.async {
            if isShown {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func reloadMoviesList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
