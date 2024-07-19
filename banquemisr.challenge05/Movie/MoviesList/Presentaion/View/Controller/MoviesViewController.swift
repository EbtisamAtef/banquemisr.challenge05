//
//  MoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 16/07/2024.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var movieTableView: UITableView!
    
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
        setup()
    }
    
    private func setup() {
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
    
    private func setupTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: MovieTableViewCell.reusableIdentifier,
                                      bundle: nil),
                                forCellReuseIdentifier: MovieTableViewCell.reusableIdentifier)
    }
    
    private func setupViewModel() {
        viewModel.getPopularMovies()
        
    }
    
    private func bindViewModel() {
        
        viewModel.movieTypePublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] movieType in
                guard let self else {return}
                viewModel.featchMovieType()
            }
            .store(in: &cancellable)
        
        viewModel.popularMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                movieTableView.reloadData()
            }
            .store(in: &cancellable)
        
        viewModel.playingNowMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                movieTableView.reloadData()
            }
            .store(in: &cancellable)
        
        viewModel.upcomingMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                movieTableView.reloadData()
            }
            .store(in: &cancellable)
        
        viewModel.upcomingMovieListPublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                movieTableView.reloadData()
            }
            .store(in: &cancellable)
        
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let movieDetails = viewModel.getMovieDetails(index: indexPath.row)
        if let url = URL(string: movieDetails.posterPath ?? "") {
            viewModel.loadImage(url: url)
        }
        cell.configureCell(data: movieDetails, imageData: viewModel.loadedImage ?? Data())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = viewModel.getMovieDetails(index: indexPath.row)
        viewModel.navigateToMovieDetails(movieDetails: movieDetails, loadedImage: viewModel.loadedImage ?? Data())
    }
    
}

extension MoviesViewController: DataTransferDelegate {
    func transferData(data: MovieType) {
        viewModel.setMovitype(data)
    }
    
}
