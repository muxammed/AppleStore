//
//  ViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// ViewController - входной таб бар контроллер с 4мя таб барами
final class TabBarViewController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        tabBar.isTranslucent = true
        tabBar.backgroundColor = UIColor(named: Constants.tabBarBackColor)
        let buyVC = BuyViewController()
        buyVC.delegate = self
        let tabOne = UINavigationController(rootViewController: buyVC)
        let laptop = UIImage(systemName: Constants.laptopIconName)
        let tabOneIcon = UITabBarItem(title: Constants.tabOneTitle, image: laptop,
                                      selectedImage: laptop)
        tabOneIcon.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabOne.tabBarItem = tabOneIcon
        let forYouVC = ForYouViewController()
        forYouVC.delegate = self
        let tabTwo = UINavigationController(rootViewController: forYouVC)
        let tabTwoIcon = UITabBarItem(title: Constants.tabTwoTitle, image: UIImage(systemName: Constants.personIcon),
                                      selectedImage: UIImage(named: Constants.personIcon))
        tabTwo.tabBarItem = tabTwoIcon
        let searchVC = SearchViewController()
        searchVC.delegate = self
        let tabThree = UINavigationController(rootViewController: searchVC)
        let tabThreeIcon = UITabBarItem(title: Constants.tabThreeTitle,
                                        image: UIImage(systemName: Constants.magnifyingglass),
                                        selectedImage: UIImage(named: Constants.magnifyingglass))
        tabThree.tabBarItem = tabThreeIcon
        let cartVC = CartViewController()
        cartVC.delegate = self
        let tabFour = UINavigationController(rootViewController: cartVC)
        let tabFourIcon = UITabBarItem(title: Constants.tabFourTitle, image: UIImage(systemName: Constants.bagIcon),
                                       selectedImage: UIImage(named: Constants.bagIcon))
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
extension TabBarViewController: SwitchModesDelegate {
    func toggleMode(to: UIUserInterfaceStyle) {
        overrideUserInterfaceStyle = to
        setNeedsStatusBarAppearanceUpdate()
    }
}
