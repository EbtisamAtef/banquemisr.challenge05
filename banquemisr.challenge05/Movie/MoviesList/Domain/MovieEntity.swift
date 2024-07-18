//
//  MovieEntity.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation


struct MovieEntity {
    
    var page: Int?
    var results: [MovieListEntity]?
}

struct MovieListEntity {
    
    var adult, video: Bool?
    var genreIds: [Int]?
    var id, voteCount: Int?
    var backdropPath, originalLanguage, originalTitle, overview, posterPath, releaseDate, title: String?
    var popularity, voteAverage: Double?
    
}


