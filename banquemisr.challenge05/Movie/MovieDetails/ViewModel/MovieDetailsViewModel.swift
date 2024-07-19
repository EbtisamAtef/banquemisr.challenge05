//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import Foundation

class MovieDetailsViewModel {
    
    var movieDetails: MovieListEntity
    var loadedImage: Data

    init(movieDetails: MovieListEntity, loadedImage: Data) {
        self.movieDetails = movieDetails
        self.loadedImage = loadedImage
    }
}
