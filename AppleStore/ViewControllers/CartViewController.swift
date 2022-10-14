//
//  CartViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// CartViewController - контроллер корзины пока пустой
final class CartViewController: UIViewController {
    
    // MARK: - Public Properties
    weak var delegate: SwitchModesDelegate?
    
    // MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.toggleMode(to: .dark)
    }
}
