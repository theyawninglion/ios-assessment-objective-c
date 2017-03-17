//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Taylor Phillips on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

    var movie = Movie() {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
      let movie = self.movie 
        self.movieNameLabel.text = movie.movieName
        self.releaseDateLabel.text = movie.releaseDate
        self.ratingLabel.text = "\(movie.rating)/10"
        self.overviewTextView.text = movie.overview
    }
}
