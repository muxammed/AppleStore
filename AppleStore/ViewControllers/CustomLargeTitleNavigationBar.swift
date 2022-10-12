//
//  CustomLargeTitleNavigationBar.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import Foundation
import UIKit

/// CustomLargeTitleNavigationBar кастомный навигатий бар что бы прицепить фото кнопку напротив лардж текста
class CustomLargeTitleNavigationBar: UINavigationBar {
    
    override func layoutSubviews() {
        if #available(iOS 11.0, *) {
                    for subview in subviews {
                        if let largeTitleLabel = subview.subviews.first(where: { $0 is UILabel }) as? UILabel {
                            let largeTitleView = subview
                            print("largeTitleView:", largeTitleView)
                            print("largeTitleLabel:", largeTitleLabel)
                            // you may customize the largeTitleView and largeTitleLabel here
                            break
                        }
                    }
                }
    }
}
