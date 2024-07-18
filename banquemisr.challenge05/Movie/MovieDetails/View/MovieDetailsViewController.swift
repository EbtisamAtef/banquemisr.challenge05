//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet private weak var movieDetailsContainerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var movieVoteAverageLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupAppearance()
        setupMovieDetailsData()

    }
    
    private func setupAppearance() {
        movieImageView.layer.cornerRadius = 10
        movieDetailsContainerView.layer.cornerRadius = 10
    }
    
    private func setupMovieDetailsData() {
        movieTitleLabel.text = viewModel.movieDetails.title
        movieReleaseDateLabel.text = viewModel.movieDetails.releaseDate
        movieVoteAverageLabel.text = "\(viewModel.movieDetails.voteAverage ?? 0)"
        overviewLabel.text = viewModel.movieDetails.overview
    }



}