//
//  CartViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// CartViewController
final class CartViewController: UIViewController {
    
    var delegate: SwitchModesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.toggleMode(to: .dark)
    }
}
