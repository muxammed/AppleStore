//
//  SearchViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

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
        searchTextField.backgroundColor = UIColor(named: Constants.textFieldBackColor)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.searchTextFieldTintColor),
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]
        searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.searchTextFieldPlaceholder,
                                                                   attributes: attributes)
        searchTextField.leftView?.tintColor = UIColor(named: Constants.searchTextFieldTintColor)
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
    
    var productsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - Public Properties
    var products: [Product] = []
    var queries: [String] = [Constants.AirPods, Constants.AppleCare, Constants.Beats, Constants.compareText]
    var productImages: [String] = [Constants.productOne, Constants.productTwo,
                                   Constants.productThree, Constants.productFour]
    var productItemWidth: CGFloat = 0.0
    weak var delegate: SwitchModesDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDummyProducts()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.searchTitle, style: .plain,
                                                           target: nil, action: nil)
        delegate?.toggleMode(to: .dark)
    }
    
    // MARK: - Public methods
    @objc func productTappedAction(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let selectedProduct = products[view.tag]
        let detailsViewController = ProductDetailsViewController()
        detailsViewController.product = selectedProduct
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func loadDummyProducts() {
        
        var product = Product(name: Constants.productNameOne, imageName: productImages[0],
                              images: [productImages[0], Constants.case2, Constants.case3],
                              productUrl: Constants.productOneUrl)
        products.append(product)
        product = Product(name: Constants.productNameTwo, imageName: productImages[1], images: [],
                          productUrl: Constants.productTwoUrl)
        products.append(product)
        product = Product(name: Constants.productNameThree, imageName: productImages[2],
                          images: [productImages[2], Constants.caseBrown2, Constants.caseBrown3],
                          productUrl: Constants.productThreeUrl)
        products.append(product)
        product = Product(name: Constants.productNameFour, imageName: productImages[3], images: [],
                          productUrl: Constants.productFourUrl)
        products.append(product)
        
    }
    
    private func addingProductViews() {
        
        productItemWidth = (view.frame.width - 20 - 16) / 2.8
        productsScrollView.frame = CGRect(x: 0, y: lastViewedLabel.frame.maxY + 30,
                                          width: view.frame.width, height: productItemWidth * 1.4)
        let seperatorsWidth = CGFloat((products.count - 1) * 8)
        let productsTotalWidth = CGFloat(CGFloat(products.count) * productItemWidth)
        let scrollViewWidth = CGFloat(40 + seperatorsWidth + productsTotalWidth)
        productsScrollView.contentSize = CGSize(width: scrollViewWidth, height: productItemWidth * 1.4)
        view.addSubview(productsScrollView)
        
        for productIndex in 0..<products.count {
            
            let xAxis = CGFloat(20 + (Int(productItemWidth) + 8) * productIndex)
            let productView = ProductView(frame: CGRect(x: xAxis, y: 0, width: productItemWidth,
                                                        height: productItemWidth * 1.4))
            productsScrollView.addSubview(productView)
            productView.productName.text = products[productIndex].name
            productView.productImage.image = UIImage(named: products[productIndex].imageName)
            productView.tag = productIndex
            let tap = UITapGestureRecognizer(target: self, action: #selector(productTappedAction(_:)))
            
            productView.addGestureRecognizer(tap)
        }
    }
    
    private func addingQueryViews() {
        for queryIndex in 0..<queries.count {
            let yAxis = CGFloat(50 * queryIndex)
            let queryView = QueryView(frame: CGRect(x: 20, y: queryOptionsLabel.frame.maxY + yAxis,
                                                    width: view.frame.width - 40, height: 50))
            queryView.queryTextLabel.text = queries[queryIndex]
            view.addSubview(queryView)
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .black
        searchTitleLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 4,
                                        width: view.frame.width - 40, height: searchTitleLabel.font.pointSize)
        view.addSubview(searchTitleLabel)
        searchTextField.frame = CGRect(x: 20, y: searchTitleLabel.frame.maxY + 10,
                                       width: view.frame.width - 40, height: 32)
        view.addSubview(searchTextField)
        lastViewedLabel.frame = CGRect(x: 20, y: searchTextField.frame.maxY + 40,
                                       width: ((view.frame.width - 40) / 3 ) * 2.3,
                                       height: lastViewedLabel.font.pointSize)
        view.addSubview(lastViewedLabel)
        clearButton.frame = CGRect(x: view.frame.width - 110, y: searchTextField.frame.maxY + 40,
                                   width: 100, height: lastViewedLabel.font.pointSize)
        view.addSubview(clearButton)
        
        addingProductViews()
        
        queryOptionsLabel.frame = CGRect(x: 20, y: lastViewedLabel.frame.maxY + (productItemWidth * 1.4) + 80,
                                         width: view.frame.width - 40, height: queryOptionsLabel.font.pointSize)
        view.addSubview(queryOptionsLabel)
        
        addingQueryViews()
    }
}
