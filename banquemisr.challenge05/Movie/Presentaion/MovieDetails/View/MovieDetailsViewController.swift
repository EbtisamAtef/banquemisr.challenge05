//
//  MovieDetailsViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var movieDetailsContainerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var movieVoteAverageLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel
    
    // MARK: - Init
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup UI
extension MovieDetailsViewController {
    private func setup() {
        setupAppearance()
        setupMovieDetailsData()
    }
    
    private func setupAppearance() {
        movieImageView.layer.cornerRadius = 10
        movieDetailsContainerView.layer.cornerRadius = 10
    }
    
    private func setupMovieDetailsData() {
        movieTitleLabel.text = "Title : " + (viewModel.movieDetails.title ?? "")
        movieReleaseDateLabel.text = "Release Date : " + (viewModel.movieDetails.releaseDate ?? "")
        movieVoteAverageLabel.text = "Vote Average : " + "\(viewModel.movieDetails.voteAverage ?? 0.0)"
        overviewLabel.text = "overview : " + (viewModel.movieDetails.overview ?? "")
        guard let urlData = viewModel.movieDetails.url else { return }
        movieImageView.image = UIImage(data: urlData)
    }
}
