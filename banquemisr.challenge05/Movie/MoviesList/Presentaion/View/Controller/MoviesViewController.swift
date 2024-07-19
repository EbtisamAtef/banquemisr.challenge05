//
//  MoviesViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 16/07/2024.
//

import UIKit
import Combine

class MoviesViewController: BaseViewController {
    
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
        setupActivityIndicator()
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
    
    private func setupActivityIndicator() {
           activityIndicator = UIActivityIndicatorView(style: .large)
           activityIndicator.center = view.center
           activityIndicator.hidesWhenStopped = true
           view.addSubview(activityIndicator)
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
        
        viewModel.errorMessagePublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] message in
                guard let self , let message else {return}
                showErrorAlert(on: self, message: message)
            }
            .store(in: &cancellable)
        
        viewModel.isLoadingPublisher
            .receive(on:DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self, let isLoading else {return}
                isLoading ? showLoader() : hideLoader()
            }
            .store(in: &cancellable)
        
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
        cell.configureCell(data: movieDetails)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = viewModel.getMovieDetails(index: indexPath.row)
        viewModel.navigateToMovieDetails(movieDetails: movieDetails)
    }
    
}

extension MoviesViewController: DataTransferDelegate {
    func transferData(data: MovieType) {
        viewModel.setupSelectedMovitype(data)
    }
    
}



