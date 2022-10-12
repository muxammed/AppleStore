//
//  ForYouViewController.swift
//  AppleStore
//
//  Created by muxammed on 10.10.2022.
//

import AVFoundation
import Foundation
import UIKit

/// протокол для переключения мода в таббар контроллере
protocol SwitchModesDelegate: AnyObject {
    func toggleMode(to: UIUserInterfaceStyle)
}

/// ForYouViewController
final class ForYouViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Visual Components
    var scrollView = UIScrollView()
    var seperator = UIView()
    var largeTitleViewRightBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        let insets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
        button.setImage(UIImage(named: "caseBrown2"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        return button
    }()
    
    var largeTitleViewRightButtonShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 22
        view.layer.shadowColor = UIColor(named: "viewBackground")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 1.5
        view.layer.shouldRasterize = true
        view.layer.shadowOpacity = 0
        return view
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "caseBrown2"))
        imageView.layer.cornerRadius = imageView.frame.height * 0.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var rightBarButtonItem = UIBarButtonItem()
    var pickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.whatsNewText
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    var orderView = OrderView()
    var recomendsView = RecommendsView()
    
    var recommendsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.recommendsForYouText
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    var devicesLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.yourDevicesText
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    var showAllLabel: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .right
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let attrs = [NSAttributedString.Key.font:
                        UIFont.systemFont(ofSize: 16, weight: .regular),
                     NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        button.setAttributedTitle(NSAttributedString(string: Constants.showAllText, attributes: attrs), for: .normal)
        return button
    }()
    
    // MARK: - Public Properties
    var delegate: SwitchModesDelegate?
    
    // MARK: - Lyfe Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        beforeAppearActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFrames()
    }
    
    // MARK: - Public methods
    @objc func showImagePickerAction() {
        present(pickerController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        largeTitleViewRightBarButton.frame.origin.y = -(scrollView.contentOffset.y + 143)
        largeTitleViewRightButtonShadowView.frame.origin.y = -(scrollView.contentOffset.y + 143)
        
        if scrollView.contentOffset.y >= -103 {
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    // MARK: - Private Methods
    private func configure() {
        scrollView.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0.3, options: .curveEaseInOut) {
            self.scrollView.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.orderView.animateDelivery()
        }

        view.addSubview(scrollView)
        scrollView.addSubview(seperator)
        scrollView.addSubview(whatsNewLabel)
        scrollView.addSubview(orderView)
        scrollView.addSubview(recommendsLabel)
        scrollView.addSubview(recomendsView)
        scrollView.addSubview(devicesLabel)
        scrollView.addSubview(showAllLabel)
        
        scrollView.delegate = self
        navigationItem.rightBarButtonItem = nil
        pickerController.delegate = self
        largeTitleViewRightBarButton.addTarget(self, action: #selector(showImagePickerAction), for: .touchUpInside)
    }
    
    private func findSubview(parentView: UIView, type: UIView.Type) -> UIView? {
        for subview in parentView.subviews {
            if subview.isKind(of: type) {
                return subview
            } else if let desiredInstance = findSubview(parentView: subview, type: type) {
                return desiredInstance
            }
        }
        return nil
     }
    
    private func setupFrames() {
        if let image = loadFromUserDefaults() {
            largeTitleViewRightBarButton.setImage(image, for: .normal)
            imageView.image = image
        }
        
        scrollView.frame = view.frame
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        seperator.backgroundColor = UIColor(named: "linesColor")?.withAlphaComponent(0.3)
        seperator.frame = CGRect(x: 10, y: 0, width: view.frame.width - 20, height: 1)
        largeTitleViewRightBarButton.frame = CGRect(x: view.frame.width - 50, y:
                                0, width: 50, height: 50)
        largeTitleViewRightButtonShadowView.frame = CGRect(x: view.frame.width - 50, y:
                                                            0, width: 50, height: 50)
        addingButtonToLargeTitleView()
        whatsNewLabel.frame = CGRect(x: 20, y: 30, width: view.frame.width - 40, height: whatsNewLabel.font.pointSize)
        
        orderView.frame = CGRect(x: 20, y: whatsNewLabel.frame.maxY + 35, width: view.frame.width - 40, height: 155)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.orderView.animateDelivery()
        }
        
        recommendsLabel.frame = CGRect(x: 20, y: orderView.frame.maxY + 100,
                                       width: view.frame.width - 40, height: recommendsLabel.font.pointSize)
        recomendsView.frame = CGRect(x: 20, y: recommendsLabel.frame.maxY + 10,
                                     width: view.frame.width - 40, height: 160)
        devicesLabel.frame = CGRect(x: 20, y: recomendsView.frame.maxY + 10,
                                    width: 200, height: devicesLabel.font.pointSize)
        showAllLabel.frame = CGRect(x: view.frame.width - 170, y: 0,
                                    width: 150, height: 40)
        showAllLabel.center.y = devicesLabel.center.y
    }
    
    private func addingBarButtonItemToNavBar() {
        let frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let customView = UIView(frame: frame)
        imageView.frame = frame
        imageView.layer.cornerRadius = imageView.frame.height * 0.5
        imageView.layer.masksToBounds = true
        customView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImagePickerAction)))
        customView.addSubview(imageView)
        rightBarButtonItem = UIBarButtonItem(customView: customView)
    }
    
    private func addingButtonToLargeTitleView() {
        guard let navCont = navigationController else { return }
        
        if let largeTitleClass = NSClassFromString("_UINavigationBarLargeTitleView") as? UIView.Type {

            if let largeTitleLabel = self.findSubview(parentView: navCont.view, type: UILabel.self) {
                if let largeTitleView = self.findSubview(parentView: navCont.view,
                                                          type: largeTitleClass) {

                    self.largeTitleViewRightBarButton.frame = CGRect(x: largeTitleView.frame.width - 64, y: 0,
                                                                     width: 44, height: 44)
                    self.largeTitleViewRightButtonShadowView.frame = CGRect(x: largeTitleView.frame.width - 64, y: 0,
                                                                            width: 44, height: 44)
                    largeTitleView.addSubview(self.largeTitleViewRightButtonShadowView)
                    largeTitleView.addSubview(self.largeTitleViewRightBarButton)
                    self.largeTitleViewRightBarButton.center.y = largeTitleLabel.center.y
                    self.largeTitleViewRightButtonShadowView.center.y = largeTitleLabel.center.y
                    self.scrollView.contentOffset.y = -145
                    self.scrollView.contentOffset.y = -143
                }
            }
        }
        
        addingBarButtonItemToNavBar()
    }
    
    private func beforeAppearActions() {
        delegate?.toggleMode(to: .light)
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "viewBackground")
        self.title = Constants.forYouText
    }
    
    private func saveToUserDefaults(image: Data) {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: "avatar") != nil else {
            defaults.setValue(image, forKey: "avatar")
            return
        }
        defaults.removeObject(forKey: "avatar")
        defaults.setValue(image, forKey: "avatar")
    }
    
    private func loadFromUserDefaults() -> UIImage? {
        let userdefaults = UserDefaults.standard
        guard let dataImage = userdefaults.object(forKey: "avatar") as? Data else {
            let image = UIImage(named: "brownCase2")
            return image
        }
        
        guard let image = UIImage(data: dataImage) else {
            let image = UIImage(named: "brownCase2")
            return image
        }
        return image
    }
}

/// UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ForYouViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true, completion: {
            UIView.animate(withDuration: 0.2) {
                self.largeTitleViewRightBarButton.alpha = 0
                self.largeTitleViewRightButtonShadowView.layer.borderWidth = 2
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.largeTitleViewRightBarButton.setImage(image, for: .normal)
                self.imageView.image = image
                if let imageData = image.pngData() {
                    self.saveToUserDefaults(image: imageData)
                }
                UIView.animate(withDuration: 0.2) {
                    self.largeTitleViewRightBarButton.alpha = 1
                    self.largeTitleViewRightButtonShadowView.layer.borderWidth = 0
                }
            }

        })
    }
}
