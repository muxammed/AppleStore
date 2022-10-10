//
//  ProductDetailsViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// ProductDetailsViewController экран с детализацией выбранного продукта
final class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    
    var productName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    fileprivate func configureFrames() {
        productName.frame = CGRect(x: 30, y: 150, width: view.frame.width - 60, height: productName.font.pointSize)
        productImage.frame = CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 300)
        productImage.center.y = view.center.y
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = .black
        view.addSubview(productName)
        view.addSubview(productImage)
     
        guard let product = self.product else { return }
        productName.text = product.name
        productImage.image = UIImage(named: product.imageName)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureFrames()
    }
}
