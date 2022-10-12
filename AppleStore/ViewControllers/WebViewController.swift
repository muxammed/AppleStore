//
//  WebViewController.swift
//  AppleStore
//
//  Created by muxammed on 11.10.2022.
//

import UIKit
import WebKit

/// WebViewController - модальный контроллер для открытия соответствующих ссылок с кнопками навигации для удобства перемещения в вебвьюв
final class WebViewController: UIViewController {
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
        
    }()
    
    let backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let forwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var bottomToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = UIColor(red: 39 / 255, green: 39 / 255, blue: 39 / 255, alpha: 1)
        toolbar.isTranslucent = false
        return toolbar
    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: UIProgressView.Style.bar)
        return progressView
    }()
    var url = "https://re-store.ru"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(webView)
        webView.navigationDelegate = self
        view.addSubview(bottomToolbar)
        bottomToolbar.addSubview(backwardButton)
        bottomToolbar.addSubview(forwardButton)
        bottomToolbar.addSubview(refreshButton)
        bottomToolbar.addSubview(shareButton)
        bottomToolbar.addSubview(progressView)
        loadWebPage(urlString: url)
        
        backwardButton.addTarget(self, action: #selector(backwardButtonAction), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
    }
    
    func loadWebPage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest.init(url: url))
        
            observation = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
                self.progressView.progress = Float(self.webView.estimatedProgress)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        bottomToolbar.frame = CGRect(x: 0, y: view.frame.height - 60, width: view.frame.width, height: 60)
        backwardButton.frame = CGRect(x: 20, y: 12.5, width: 20, height: 20)
        forwardButton.frame = CGRect(x: backwardButton.frame.maxX + 10, y: 12.5, width: 20, height: 20)
        shareButton.frame = CGRect(x: bottomToolbar.frame.width - 40, y: 10, width: 25, height: 25)
        refreshButton.frame = CGRect(x: shareButton.frame.minX - 35, y: 10, width: 25, height: 25)
        let progressWidth = refreshButton.frame.minX - forwardButton.frame.maxX - 20
        progressView.frame = CGRect(x: forwardButton.frame.maxX + 10, y: 0, width: progressWidth, height: 1)
        progressView.center.y = refreshButton.center.y
    }
    
    private var observation: NSKeyValueObservation?
    
    deinit {
        observation = nil
    }
    
    @objc func forwardButtonAction() {
        webView.goForward()
    }
    
    @objc func backwardButtonAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func refreshButtonAction() {
        webView.reload()
    }
    
    @objc func shareButtonAction() {
        guard let url = webView.url else { return }
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        self.progressView.layer.masksToBounds = false
        self.progressView.layer.shadowColor = UIColor.white.cgColor
        self.progressView.layer.shadowRadius = 10
        self.progressView.layer.shadowOpacity = 0
        self.progressView.layer.shouldRasterize = false
        self.progressView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        UIView.animate(withDuration: 1) {
            self.progressView.tintColor = .systemGreen
            self.progressView.layer.shadowOpacity = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            
            UIView.animate(withDuration: 0.5) {
                self.progressView.alpha = 0
            } completion: { _ in
                self.progressView.progress = 0
                self.progressView.tintColor = .systemIndigo
                self.progressView.layer.shadowOpacity = 0
                self.progressView.alpha = 1
            }

        }

    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.tintColor = .systemIndigo
    }

}
