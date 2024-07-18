//
//  UITableView+extension.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import Foundation
import UIKit

extension UITableView {
    
    public func registerReusableCell<T: UITableViewCell>(_ cells: T.Type) {
            register(T.self, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
