//
//  RecommendsView.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import UIKit

/// RecommendsView - вьюв для переиспользования и показа рекомендаций
class RecommendsView: UIView {
   
    let recomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "app.badge")
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let recomTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = Constants.notifyText
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let recomSummaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = Constants.notifySubText
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor(named: "searchTextFieldTintColor")
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "searchTextFieldTintColor")?.withAlphaComponent(0.5)
        return view
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
        backgroundColor = .white
        
        addSubview(recomImageView)
        recomImageView.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        addSubview(recomTitleLabel)
        addSubview(recomSummaryLabel)
        addSubview(seperatorView)
        addSubview(arrowButton)
    }
    
    override func layoutSubviews() {
        recomTitleLabel.frame = CGRect(x: recomImageView.frame.maxX + 20, y: recomImageView.frame.minY,
                                        width: self.frame.width - 120, height: recomTitleLabel.font.pointSize * 4)
        recomSummaryLabel.frame = CGRect(x: recomImageView.frame.maxX + 20, y: recomTitleLabel.frame.maxY,
                                        width: self.frame.width - 120, height: recomSummaryLabel.font.pointSize * 3)
        seperatorView.frame = CGRect(x: 0, y: recomSummaryLabel.frame.maxY + 20, width: self.frame.width, height: 0.55)
        
        arrowButton.frame = CGRect(x: frame.width - 30, y: 0, width: 10, height: 15)
        arrowButton.center.y = frame.height / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
