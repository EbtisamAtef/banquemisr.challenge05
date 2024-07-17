//
//  MoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 16/07/2024.
//

import UIKit
import Combine
import NetworkService

class MoviesViewController: UIViewController {
    
    let viewModel: MovieViewModelType
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: MovieViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        bindViewModel()
    }
    
    
    
    private func setupViewModel() {
        viewModel.getPopularMovies()
        viewModel.getNowPlayingMovies()
        viewModel.getUpcomingMovies()
    }
    
    private func bindViewModel() {
        viewModel.popularMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { movie in
                print("popular movies ..", movie)
            }
            .store(in: &cancellable)
        
        viewModel.playingNowMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { movie in
                print("playingNow movies ..", movie)
            }
            .store(in: &cancellable)
        
        viewModel.upcomingMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { movie in
                print("upcoming movies ..", movie)
            }
            .store(in: &cancellable)
        
    }
  


}



