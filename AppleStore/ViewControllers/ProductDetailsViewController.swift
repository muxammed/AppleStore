//
//  ProductDetailsViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// энам для названия картинок
enum Images: String {
    case share = "square.and.arrow.up"
    case favorite = "heart"
}

/// ProductDetailsViewController экран с детализацией выбранного продукта
final class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    
    var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
        label.text = Constants.productPrice
        label.textAlignment = .center
        return label
    }()
    
    var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var imagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    var indicatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.8)
        return view
    }()
    
    var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    var productNameSmallerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let buttonsView = UIView()
    let circleOne: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16.5
        button.clipsToBounds = true
        return button
    }()
    
    let circleTwo: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16.5
        button.clipsToBounds = true
        return button
    }()
    
    let circleBorder: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 255, alpha: 0.8).cgColor
        return view
    }()
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")?
            .withTintColor(.black, renderingMode: .alwaysTemplate)
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 64 / 255, green: 210 / 255, blue: 85 / 255, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let compatibleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
        return label
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        button.setAttributedTitle(NSAttributedString(string: Constants.addToCartText, attributes: attr), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 47 / 255, green: 133 / 255, blue: 255 / 255, alpha: 1)
        return button
    }()
    
    let cubeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cube.box")
        imageView.tintColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
        return imageView
    }()
    
    let bottomOneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = .white
        label.text = Constants.bottomTextOne
        return label
    }()
    
    let bottomTwoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
        label.text = Constants.bottomTextTwo
        return label
    }()
    
    let bottomThreeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .systemBlue
        label.text = Constants.bottomTextThree
        label.isUserInteractionEnabled = true
        return label
    }()
    
    fileprivate func configureFrames() {
        productNameLabel.frame = CGRect(x: 10, y: 120, width: view.frame.width - 20,
                                        height: productNameLabel.font.pointSize)
        productImageView.frame = CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 300)
        productImageView.center.y = view.center.y
        productPriceLabel.frame = CGRect(x: 10, y: productNameLabel.frame.maxY + 10,
                                    width: view.frame.width - 20, height: productPriceLabel.font.pointSize)
        imagesScrollView.frame = CGRect(x: 0, y: productPriceLabel.frame.maxY + 10,
                                        width: view.frame.width, height: 250)
        imagesScrollView.contentSize = CGSize(width: view.frame.width * 3, height: 250)
        indicatorLineView.frame = CGRect(x: 10, y: imagesScrollView.frame.maxY + 3,
                                         width: view.frame.width - 20, height: 1.8)
        indicatorView.frame = CGRect(x: 0, y: 0, width: indicatorLineView.frame.width / 3, height: 1.5)
        indicatorView.center.y = indicatorLineView.frame.height / 2
        productNameSmallerLabel.frame = CGRect(x: 10, y: imagesScrollView.frame.maxY + 22, width: view.frame.width - 20,
                                               height: productNameSmallerLabel.font.pointSize)
        
        loadScrollViewContent()
        
        buttonsView.frame = CGRect(x: 0, y: productNameSmallerLabel.frame.maxY + 50, width: 100, height: 50)
        circleOne.frame = CGRect(x: 10, y: 0, width: 33, height: 33)
        circleTwo.frame = CGRect(x: 60, y: 0, width: 33, height: 33)
        
        addingGradientToCircleViews()
        
        circleBorder.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        circleBorder.center = circleTwo.center
        buttonsView.center.x = view.center.x
        
        checkImageView.frame = CGRect(x: 80, y: buttonsView.frame.maxY + 20, width: 20, height: 20)
        manageAttributedString()
        compatibleTextLabel.frame = CGRect(x: checkImageView.frame.maxX + 10, y: 0,
                                           width: 240, height: compatibleTextLabel.font.pointSize)
        compatibleTextLabel.center.y = checkImageView.center.y
        
        addToCartButton.frame = CGRect(x: 10, y: compatibleTextLabel.frame.maxY + 40,
                                       width: view.frame.width - 20, height: 37)
        cubeImage.frame = CGRect(x: 15, y: addToCartButton.frame.maxY + 40, width: 19, height: 19)
        
        bottomOneLabel.frame = CGRect(x: cubeImage.frame.maxX + 10, y: addToCartButton.frame.maxY + 40,
                                      width: view.frame.width - 50, height: bottomOneLabel.font.pointSize)
        bottomTwoLabel.frame = CGRect(x: cubeImage.frame.maxX + 10, y: bottomOneLabel.frame.maxY + 4,
                                      width: view.frame.width - 50, height: bottomOneLabel.font.pointSize)
        bottomThreeLabel.frame = CGRect(x: cubeImage.frame.maxX + 10, y: bottomTwoLabel.frame.maxY + 3,
                                      width: view.frame.width - 50, height: bottomOneLabel.font.pointSize)
    }
    
    @objc func goToWebView() {
        let webViewController = WebViewController()
        guard let product = product else { return }
        webViewController.url = product.productUrl
        present(webViewController, animated: true, completion: nil)
    }
    
    func manageAttributedString() {
        var attrString = AttributedString(Constants.compatibleTextOne)
        guard let range = attrString.range(of: Constants.compatibleTextTwo) else { return }
        attrString[range].foregroundColor = UIColor.systemBlue
        compatibleTextLabel.attributedText = NSAttributedString(attrString)
    }
    
    func addingGradientToCircleViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = circleOne.frame.size
        gradientLayer.colors = [UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1),
                                UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1)]
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame.size = circleTwo.frame.size
        gradientLayer2.colors = [UIColor(red: 152 / 255, green: 152 / 255, blue: 152 / 255, alpha: 1),
                                UIColor(red: 164 / 255, green: 164 / 255, blue: 164 / 255, alpha: 1)]
        
//        circleOne.backgroundColor = UIColor(red: 152 / 255, green: 152 / 255, blue: 152 / 255, alpha: 1)
        circleTwo.backgroundColor = UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)
        circleOne.applyGradient(colours: [UIColor(red: 152 / 255, green: 152 / 255, blue: 152 / 255, alpha: 1),
                                          UIColor(red: 164 / 255, green: 164 / 255, blue: 164 / 255, alpha: 1)])
//        circleOne.layer.addSublayer(gradientLayer)
//        circleTwo.layer.addSublayer(gradientLayer2)
    }
    
    func loadScrollViewContent() {
        guard let product = self.product else { return }
        
        for imageIndex in 0..<product.images.count {
            
            let pageView = UIView(frame: CGRect(x: CGFloat(imageIndex) * view.frame.width, y: 0,
                                                width: imagesScrollView.frame.width, height: 250))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 220))
            imageView.center.x = pageView.frame.width / 2
            imageView.center.y = pageView.frame.height / 2
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: product.images[imageIndex])
            pageView.addSubview(imageView)
            imagesScrollView.addSubview(pageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view?.backgroundColor = .black
        imagesScrollView.delegate = self
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(imagesScrollView)
        view.addSubview(indicatorLineView)
        indicatorLineView.addSubview(indicatorView)
        view.addSubview(productNameSmallerLabel)
        view.addSubview(buttonsView)
        buttonsView.addSubview(circleOne)
        buttonsView.addSubview(circleTwo)
        buttonsView.addSubview(circleBorder)
        view.addSubview(checkImageView)
        view.addSubview(compatibleTextLabel)
        view.addSubview(addToCartButton)
        view.addSubview(cubeImage)
        view.addSubview(bottomOneLabel)
        view.addSubview(bottomTwoLabel)
        view.addSubview(bottomThreeLabel)
        
        guard let product = self.product else { return }
        productNameLabel.text = product.name
        productImageView.image = UIImage(named: product.imageName)
        productNameSmallerLabel.text = product.name
        imagesScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToWebView)))
        bottomThreeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewPdfFile)))
    }
    
    @objc func viewPdfFile() {
        present(PdfViewController(), animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configOnViewWillAppear()
    }
    
    func configOnViewWillAppear() {
        navigationController?.navigationBar.backgroundColor = .gray
        let shareButton = UIBarButtonItem(image: UIImage(systemName: Images.share.rawValue),
                                          style: .plain, target: nil, action: nil)
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: Images.favorite.rawValue),
                                             style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [favoriteButton, shareButton]
        
        navigationController?.navigationBar.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255,
                                                                      blue: 18 / 255, alpha: 1)
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 85))
        topView.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1)
        view.addSubview(topView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureFrames()
    }
}

/// UIScrollViewDelegate
extension ProductDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5) {
            self.indicatorLineView.alpha = 1
        }
        indicatorView.frame.origin.x = (scrollView.contentOffset.x - 20) / 3
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5) {
            self.indicatorLineView.alpha = 0.8
        }
    }
}
