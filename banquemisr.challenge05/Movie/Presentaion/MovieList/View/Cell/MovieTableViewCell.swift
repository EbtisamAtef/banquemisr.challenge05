//
//  MovieTableViewCell.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    private func setupAppearance() {
        movieImageView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
    }
    
    func configureCell(data: MovieListEntity) {
        movieTitleLabel.text = data.title
        movieReleaseDateLabel.text = data.releaseDate
        guard let urlData = data.url else { return }
        movieImageView.image = UIImage(data: urlData)
    }
}
