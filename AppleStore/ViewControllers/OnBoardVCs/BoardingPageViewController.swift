//
//  BoardingPageViewController.swift
//  AppleStore
//
//  Created by muxammed on 14.10.2022.
//

import UIKit

/// BoardingPageViewController экран онбординга один с переиспользованием
final class BoardingPageViewController: UIViewController {
    
    // MARK: - Visual components
    var boardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    var boardTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 28)
        label.alpha = 0
        return label
    }()
    
    var boardSummaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.alpha = 0
        return label
    }()
    
    // MARK: - Initializers
    init(withPage: BoardPageHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
        edgesForExtendedLayout = []
        boardImage.image = withPage.image
        boardImage.frame = view.frame
        boardTitleLabel.text = withPage.title
        boardTitleLabel.frame = CGRect(x: 0, y: ((view.frame.height / 3) * 2) + 10,
                                       width: view.frame.width, height: boardTitleLabel.font.pointSize)
        
        boardSummaryLabel.text = withPage.description
        boardSummaryLabel.frame = CGRect(x: 0, y: boardTitleLabel.frame.maxY + 10,
                                       width: view.frame.width - 60, height: boardTitleLabel.font.pointSize * 3)
        boardSummaryLabel.center.x = view.center.x
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.boardTitleLabel.alpha = 1
            self.boardSummaryLabel.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.5) {
            self.boardTitleLabel.alpha = 0
            self.boardSummaryLabel.alpha = 0
        }
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(boardImage)
        view.addSubview(boardTitleLabel)
        view.addSubview(boardSummaryLabel)
    }
}
