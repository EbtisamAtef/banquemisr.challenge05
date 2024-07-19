//
//  MovieDTO.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation


struct MovieDTO: Codable, Equatable {
    var page: Int?
    var results: [MovieList]?
}

struct MovieList: Codable , Equatable{
    var adult, video: Bool?
    var genre_ids: [Int]?
    var id, vote_count: Int?
    var backdrop_path, original_language, original_title, overview, poster_path, release_date, title: String?
    var popularity, vote_average: Double?
    
    static func == (lhs: MovieList, rhs: MovieList) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title && lhs.release_date == rhs.release_date
        }
    
}
