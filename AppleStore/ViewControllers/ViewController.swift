//
//  ViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// ViewController - входной таб бар контроллер с 4мя таб барами
final class ViewController: UITabBarController {

    // MARK: - Public Properties
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: - Private Methods
    fileprivate func configure() {
        tabBar.barTintColor = .purple
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1)
        let tabOne = UINavigationController(rootViewController: BuyViewController())
        let laptop = UIImage(named: "laptop")?.imageResized(to: CGSize(width: 50, height: 50))
        let tabOneIcon = UITabBarItem(title: "Купить", image: laptop,
                                      selectedImage: laptop)
        tabOneIcon.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabOne.tabBarItem = tabOneIcon
        let tabTwo = UINavigationController(rootViewController: ForYouViewController())
        let tabTwoIcon = UITabBarItem(title: "Для Вас", image: UIImage(systemName: "person.circle"),
                                      selectedImage: UIImage(named: "person.circle"))
        tabTwo.tabBarItem = tabTwoIcon
        let tabThree = UINavigationController(rootViewController: SearchViewController())
        let tabThreeIcon = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"),
                                        selectedImage: UIImage(named: "magnifyingglass"))
        tabThree.tabBarItem = tabThreeIcon
        let tabFour = UINavigationController(rootViewController: CartViewController())
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
