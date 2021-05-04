//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import UIKit

class MoviesListViewController: UIViewController {
    private let viewModel: MoviesListViewModel = MoviesListViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        setupView()
    }
    
    func setupView() {
        self.title = "Movies"
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListItemViewCell", for: indexPath) as? MoviesListItemViewCell {
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
        // TODO: Move to Movie Details screen
    }
}

