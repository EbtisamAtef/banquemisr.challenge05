//
//  MoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 16/07/2024.
//

import UIKit
import NetworkService

class MoviesViewController: UIViewController {
    
    var apiClient: HttpClientProtocol = HttpClient()

    override func viewDidLoad() {
        super.viewDidLoad()
         getAsyncEvents()
    }
    
    func getAsyncEvents() {
        let endpoint = EventsEndpoints.getMovie
        Task {
            do {
                let movie = try await apiClient.performRequest(endpoint: endpoint, responseModel: MovieModel.self)
                print("Movie list is \(String(describing: movie.results))")
            } catch let error as ApiErrorModel{
                print("error is \(String(describing: error.statusMessage))")
            }
        }
    }


}


enum EventsEndpoints: EndpointProvider {
    

    case getMovie

    var path: String {
        switch self {
        case .getMovie:
            return "popular"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var mockFile: String? {
        switch self {
        case .getMovie:
            return "_getEventsMockResponse"
        }
    }
}


struct MovieModel: Codable {
    var page: Int?
    var results: [MovieListModel]?
}

struct MovieListModel: Codable {
    var adult: Bool?
    var genre_ids: [Int]?
    var id, vote_count: Int?
    var backdrop_path, original_language, original_title, overview, poster_path, release_date, title, video: String?
    var popularity, vote_average: Double?
    
}


//"page": 1,
//  "results": [
//    {
//      "adult": false,
//      "backdrop_path": "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg",
//      "genre_ids": [
//        16,
//        10751,
//        12,
//        35,
//        18
//      ],
//      "id": 1022789,
//      "original_language": "en",
//      "original_title": "Inside Out 2",
//      "overview": "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
//      "popularity": 6482.514,
//      "poster_path": "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
//      "release_date": "2024-06-11",
//      "title": "Inside Out 2",
//      "video": false,
//      "vote_average": 7.702,
//      "vote_count": 1826
//    },
