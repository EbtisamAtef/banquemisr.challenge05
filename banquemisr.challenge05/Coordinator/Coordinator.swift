//
//  Coordinator.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var window: UIWindow { get }
    func start()
}
