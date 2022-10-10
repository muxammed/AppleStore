//
//  ProductView.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// кастомный вьюв для переиспользования и показа продукции
final class ProductView: UIView {
    
    var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        configureFrames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1)
        
        addSubview(productImage)
        addSubview(productName)
    }
    
    private func configureFrames() {
        productImage.frame = CGRect(x: 16, y: 16, width: self.frame.width - 32, height: self.frame.width - 32)
        addSubview(productImage)
        
        productName.frame = CGRect(x: 8, y: productImage.frame.maxY - 16, width: self.frame.width - 16,
                                   height: self.frame.height - productImage.frame.height)
        addSubview(productName)

    }
}
