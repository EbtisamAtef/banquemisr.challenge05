//
//  TabBarViewController.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit
import NetworkService

protocol DataTransferDelegate: AnyObject {
    func transferData(data: MovieType)
}

class TabBarViewController: UITabBarController {
    
    private let coordinator: MovieCoordinator
    
    init(coordinator: MovieCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        title = "Popular"
        setControllers()
        setTabBarItemsTitle()
        setupAppearnce()
        delegate = self
    }
    
    private func setupAppearnce() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .selected)
    }
    
    private func setControllers() {
        let controllers = getControllers()
        setViewControllers(controllers, animated: true)
    }
    
    private func setTabBarItemsTitle() {
        let titles = ["Popular", "Playing now", "Upcoming"]
        guard let items = tabBar.items else {return}
        for item in 0..<items.count {
            items[item].title = titles[item]
        }
    }
    
    func getControllers() -> [UIViewController] {
        let popular = setupMoviesViewController()
        let playingNow = setupMoviesViewController()
        let upcoming = setupMoviesViewController()
        return [popular, playingNow, upcoming]
    }
    
    func setupMoviesViewController()-> UIViewController {
        let apiClient = HttpClient()
        let repo = MovieRepository(apiClient: apiClient)
        let useCase = MovieUseCase(movieRepo: repo)
        let viewModel = MovieViewModel(usecase: useCase)
        viewModel.coordinator = coordinator
        let controller = MoviesViewController(viewModel: viewModel)
        return controller
    }
}



extension TabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedTabBarItem = MovieType(rawValue: tabBarController.selectedIndex) ?? .popular
        if let dataTransfer = viewController as? DataTransferDelegate {
            dataTransfer.transferData(data: selectedTabBarItem)
        }
    }
}
