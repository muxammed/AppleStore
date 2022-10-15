//
//  OrderView.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import UIKit

/// OrderView кастомный вьюв для переиспользования и вывода данных о заказах
final class OrderView: UIView {
    
    // MARK: - Visual Components
    let orderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.airpods)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let orderStatusLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.yourOrderSendedText
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let orderSummaryLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.orderSummaryText
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(named: Constants.searchTextFieldTintColor)
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.searchTextFieldTintColor)?.withAlphaComponent(0.5)
        return view
    }()
    
    let progressView: ProgressView = {
        let progressView = ProgressView()
        progressView.trackTintColor = UIColor(named: Constants.trackTintColor)
        progressView.progressTintColor = UIColor(named: Constants.progressTintColor)
        progressView.progress = 0.0
        progressView.clipsToBounds = true
        return progressView
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.strelka), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let inProgressLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.inProgressText
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    let isSendedLabal: UILabel = {
        let label = UILabel()
        label.text = Constants.sendedText
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    let isDeliveredLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.deliveredText
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Public Properties
    func animateDelivery() {
        inProgressLabel.textColor = .black
        
        UIView.animate(withDuration: 1.5) {
            self.progressView.setProgress(0.5, animated: true)
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.isSendedLabal.textColor = .black
            })
        }

    }
    
    func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shouldRasterize = true
        
        addSubview(orderImageView)
        orderImageView.frame = CGRect(x: 20, y: 20, width: 60, height: 60)
        addSubview(orderStatusLabel)
        addSubview(orderSummaryLabel)
        addSubview(seperatorView)
        addSubview(progressView)
        addSubview(arrowButton)
        addSubview(inProgressLabel)
        addSubview(isSendedLabal)
        addSubview(isDeliveredLabel)
        
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController(*)
    override func layoutSubviews() {
        orderStatusLabel.frame = CGRect(x: orderImageView.frame.maxX + 20, y: orderImageView.frame.minY,
                                        width: self.frame.width - 120, height: orderStatusLabel.font.pointSize)
        orderSummaryLabel.frame = CGRect(x: orderImageView.frame.maxX + 25, y: orderStatusLabel.frame.maxY + 10,
                                        width: self.frame.width - 140, height: orderSummaryLabel.font.pointSize)
        seperatorView.frame = CGRect(x: 0, y: orderImageView.frame.maxY + 15, width: self.frame.width, height: 0.55)
        
        progressView.backgroundColor = .gray
        progressView.frame = CGRect(x: 10, y: seperatorView.frame.maxY + 10,
                                    width: seperatorView.frame.width - 20, height: 20)
        progressView.subviews[1].frame = CGRect(x: 0, y: 0,
                                                width: progressView.frame.width, height: progressView.frame.height)
        progressView.subviews[1].clipsToBounds = true
        
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.layer.cornerRadius = progressView.frame.height / 2
        progressView.clipsToBounds = true
        guard let layers = progressView.layer.sublayers else { return }
        layers[1].cornerRadius = progressView.frame.height / 2
        progressView.subviews[1].clipsToBounds = true
        
        arrowButton.frame = CGRect(x: frame.width - 30, y: 0, width: 10, height: 15)
        arrowButton.center.y = orderSummaryLabel.center.y
        
        inProgressLabel.frame = CGRect(x: 10, y: progressView.frame.maxY + 10,
                                       width: 120, height: inProgressLabel.font.pointSize)
        isSendedLabal.frame = CGRect(x: 0, y: progressView.frame.maxY + 10,
                                     width: 80, height: isSendedLabal.font.pointSize)
        isSendedLabal.center.x = frame.width / 2
        isDeliveredLabel.frame = CGRect(x: frame.width - 90, y: progressView.frame.maxY + 10,
                                        width: 80,
                                        height: isDeliveredLabel.font.pointSize)
        
    }
}
