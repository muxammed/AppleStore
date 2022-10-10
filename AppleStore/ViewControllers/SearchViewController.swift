//
//  SearchViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// константы
struct Constants {
    static let searchTitle = "Поиск"
    static let searchTextFieldPlaceholder = "Поиск по продуктам и магазинам"
    static let lastViewed = "Недавно просмотренные"
    static let clearText = "Очистить"
    static let queryOptionsText = "Варианты запросов"
    static let productNameOne = "Чехол Incase Flat для MacBook Pro 16 дюймов"
    static let productNameTwo = "Спортивный ремешок Black Unity (для ..."
    static let productNameThree = "Кожанный чехол для MacBook Pro 16 дюймов, золотой"
}

/// SearchViewController контроллер поиска
final class SearchViewController: UIViewController {
    
    // MARK: - Visual Components
    var searchTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.text = Constants.searchTitle
        return label
    }()
    var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.placeholder = Constants.searchTextFieldPlaceholder
        searchTextField.backgroundColor = UIColor(red: 28 / 255, green: 28 / 255, blue: 30 / 255, alpha: 1)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 130 / 255, green: 130 / 255, blue: 130 / 255, alpha: 1),
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]
        searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.searchTextFieldPlaceholder, attributes: attributes)
        searchTextField.leftView?.tintColor = UIColor(red: 130 / 255, green: 130 / 255, blue: 130 / 255, alpha: 1)
        return searchTextField
    }()
    var lastViewedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.text = Constants.lastViewed
        return label
    }()
    let clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        button.setAttributedTitle(NSAttributedString(string: Constants.clearText, attributes: attributes), for: .normal)
        return button
    }()
    
    var queryOptionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.text = Constants.queryOptionsText
        return label
    }()
    
    // MARK: - Public Properties
    var products: [Product] = []
    var queries: [String] = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
    var productImages: [String] = ["productOne", "productTwo", "productThree"]
    var productItemWidth: CGFloat = 0.0
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDummyProducts()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureViews()
    }
    
    // MARK: - Public methods
    @objc func productTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let selectedProduct = products[view.tag]
        let detailsViewController = ProductDetailsViewController()
        detailsViewController.product = selectedProduct
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func loadDummyProducts() {
        
        var product = Product(name: Constants.productNameOne, imageName: productImages[0])
        products.append(product)
        product = Product(name: Constants.productNameTwo, imageName: productImages[1])
        products.append(product)
        product = Product(name: Constants.productNameThree, imageName: productImages[2])
        products.append(product)
        
    }
    
    fileprivate func addingProductViews() {
        for productIndex in 0..<products.count {
            productItemWidth = (view.frame.width - 20 - 16) / 2.8
            let xAxis = CGFloat(20 + (Int(productItemWidth) + 8) * productIndex)
            let productView = ProductView(frame: CGRect(x: xAxis, y: lastViewedLabel.frame.maxY + 30, width: productItemWidth, height: productItemWidth * 1.4))
            view.addSubview(productView)
            productView.productName.text = products[productIndex].name
            productView.productImage.image = UIImage(named: products[productIndex].imageName)
            productView.tag = productIndex
            let tap = UITapGestureRecognizer(target: self, action: #selector(productTapped(_:)))
            
            productView.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func addingQueryViews() {
        for queryIndex in 0..<queries.count {
            let yAxis = CGFloat(50 * queryIndex)
            let queryView = QueryView(frame: CGRect(x: 20, y: queryOptionsLabel.frame.maxY + yAxis, width: view.frame.width - 40, height: 50))
            queryView.queryTextLabel.text = queries[queryIndex]
            view.addSubview(queryView)
        }
    }
    
    fileprivate func configureViews() {
        view.backgroundColor = .black
        searchTitleLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 4, width: view.frame.width - 40, height: searchTitleLabel.font.pointSize)
        view.addSubview(searchTitleLabel)
        searchTextField.frame = CGRect(x: 20, y: searchTitleLabel.frame.maxY + 10, width: view.frame.width - 40, height: 32)
        view.addSubview(searchTextField)
        lastViewedLabel.frame = CGRect(x: 20, y: searchTextField.frame.maxY + 40, width: ((view.frame.width - 40) / 3 ) * 2.3, height: lastViewedLabel.font.pointSize)
        view.addSubview(lastViewedLabel)
        clearButton.frame = CGRect(x: view.frame.width - 110, y: searchTextField.frame.maxY + 40, width: 100, height: lastViewedLabel.font.pointSize)
        view.addSubview(clearButton)
        
        addingProductViews()
        
        queryOptionsLabel.frame = CGRect(x: 20, y: lastViewedLabel.frame.maxY + (productItemWidth * 1.4) + 80,
                                         width: view.frame.width - 40, height: queryOptionsLabel.font.pointSize)
        view.addSubview(queryOptionsLabel)
        
        addingQueryViews()
    }
}
