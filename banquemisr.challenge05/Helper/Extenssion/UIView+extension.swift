//
//  UIView+extension.swift
//  banquemisr.challenge05
//
//  Created by mac on 18/07/2024.
//

import UIKit

extension UIView {
    public static var reusableIdentifier: String {
        String(describing: Self.self)
    }
}
