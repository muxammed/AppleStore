//
//  BuyViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit
/// BuyViewController - контроллер для покупки пока пустой
final class BuyViewController: UIViewController {
    
    // MARK: - Public Properties
    weak var delegate: SwitchModesDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: Constants.viewBackground)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.toggleMode(to: .dark)
    }
}
