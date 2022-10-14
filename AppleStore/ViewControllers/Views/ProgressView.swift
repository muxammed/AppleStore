//
//  ProgressView.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import UIKit

/// ProgressView кастомный прогрсс вьюв с закруглением краев
final class ProgressView: UIProgressView {
    
    // MARK: - UIViewController(*)
     override func layoutSubviews() {
          super.layoutSubviews()
          let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2)
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = maskLayerPath.cgPath
          layer.mask = maskLayer
      }
}
