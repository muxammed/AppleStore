//
//  Extension+UIView.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit
/// Extension для добавления градиент лаера вью
extension UIView {

    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return applyGradient(colours: colours, locations: nil)
    }

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
