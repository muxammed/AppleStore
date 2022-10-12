//
//  BuyViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit
/// BuyViewController
final class BuyViewController: UIViewController {
    
    var delegate: SwitchModesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "viewBackground")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.toggleMode(to: .dark)
    }
}
