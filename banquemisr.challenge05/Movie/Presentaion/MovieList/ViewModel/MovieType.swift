//
//  MovieType.swift
//  banquemisr.challenge05
//
//  Created by mac on 19/07/2024.
//

import Foundation

enum MovieType: Int{
    
    case popular = 0
    case playingNow = 1
    case upcoming = 2
    
    var title: String {
        switch self {
        case .popular:
            return "Popular Movies"
        case .playingNow:
            return "Playing Now Movies"
        case .upcoming:
            return "Upcoming  Movies"
        }
    }
}
