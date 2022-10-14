//
//  ViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// ViewController - входной таб бар контроллер с 4мя таб барами
final class ViewController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    // MARK: - Private Methods
    fileprivate func configure() {
//        tabBar.barTintColor = .purple
        tabBar.isTranslucent = true
        tabBar.backgroundColor = UIColor(named: "tabBarBackColor")
        let buyVC = BuyViewController()
        buyVC.delegate = self
        let tabOne = UINavigationController(rootViewController: buyVC)
        let laptop = UIImage(systemName: "laptopcomputer.and.iphone")
        // ?.imageResized(to: CGSize(width: 50, height: 50))
        let tabOneIcon = UITabBarItem(title: "Купить", image: laptop,
                                      selectedImage: laptop)
        tabOneIcon.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabOne.tabBarItem = tabOneIcon
        let forYouVC = ForYouViewController()
        forYouVC.delegate = self
        let tabTwo = UINavigationController(rootViewController: forYouVC)
        let tabTwoIcon = UITabBarItem(title: "Для Вас", image: UIImage(systemName: "person.circle"),
                                      selectedImage: UIImage(named: "person.circle"))
        tabTwo.tabBarItem = tabTwoIcon
        let searchVC = SearchViewController()
        searchVC.delegate = self
        let tabThree = UINavigationController(rootViewController: searchVC)
        let tabThreeIcon = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"),
                                        selectedImage: UIImage(named: "magnifyingglass"))
        tabThree.tabBarItem = tabThreeIcon
        let cartVC = CartViewController()
        cartVC.delegate = self
        let tabFour = UINavigationController(rootViewController: cartVC)
        let tabFourIcon = UITabBarItem(title: "Корзина", image: UIImage(systemName: "bag"),
                                       selectedImage: UIImage(named: "bag"))
        tabFour.tabBarItem = tabFourIcon
        let controllers = [tabOne, tabTwo, tabThree, tabFour]
        self.viewControllers = controllers
    }
    
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

/// SwitchModesDelegate
extension ViewController: SwitchModesDelegate {
    func toggleMode(to: UIUserInterfaceStyle) {
        overrideUserInterfaceStyle = to
        setNeedsStatusBarAppearanceUpdate()
    }
}
