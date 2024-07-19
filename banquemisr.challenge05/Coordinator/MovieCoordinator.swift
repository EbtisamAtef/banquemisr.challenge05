//
//  AppCoordinator.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

struct MovieCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let tabBar = TabBarViewController(coordinator: self)
        navigationController.viewControllers = [tabBar]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToMovieDetails(with details: MovieListEntity, loadedImage: Data) {
        let viewModel = MovieDetailsViewModel(movieDetails: details, loadedImage: loadedImage) 
        let controller = MovieDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    
    
    
}
