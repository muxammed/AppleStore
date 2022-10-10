//
//  QueryView.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import UIKit

/// Кастомный вьюв для отображения и переиспользования вариантов запросов
final class QueryView: UIView {
    
    let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = UIColor(red: 130 / 255, green: 130 / 255, blue: 130 / 255, alpha: 1)
        return imageView
    }()
    
    var queryTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFrames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(searchIcon)
        addSubview(queryTextLabel)
        addSubview(seperatorView)
    }
    
    private func configureFrames() {
        searchIcon.frame = CGRect(x: 10, y: 0, width: 18, height: 18)
        searchIcon.center.y = self.frame.height / 2
        queryTextLabel.frame = CGRect(x: searchIcon.frame.maxX + 8, y: 0, width: self.frame.width - 16, height: queryTextLabel.font.pointSize)
        queryTextLabel.center.y = self.frame.height / 2
        seperatorView.frame = CGRect(x: 0, y: searchIcon.frame.maxY + 10, width: self.frame.width, height: 1)
    }
    
}
