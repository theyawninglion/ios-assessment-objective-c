//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let movieController = MovieController()
        movieController.fetchMovie(fromSearchTerm: searchTerm) { (movie) in
            guard let movie = movie else { return }
            DispatchQueue.main.async {
                self.movies = movie
            }
            self.resignFirstResponder()
        }
//        searchBar.text = ""
    }

    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell ?? MovieTableViewCell()
        let movie = self.movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
}
