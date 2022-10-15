//
//  OnBoardingViewController.swift
//  AppleStore
//
//  Created by muxammed on 14.10.2022.
//

import UIKit

final class OnBoardingViewController: UIViewController {
    
    // MARK: - Visual Components
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.nextText, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.skipText, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.startText, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isHidden = true
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Public Properties
    var pageContainer = UIPageViewController()
    var pageController = UIPageControl()
    var onboardingPages: [BoardPageHelper] = [BoardPageHelper]()
    var onboardingPagesViewControllers: [BoardingPageViewController] = [BoardingPageViewController]()
    var currentPage = 0
    weak var delegate: SwitchModesDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.toggleMode(to: .dark)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createOnboardingData()
    }
    
    // MARK: - Public Methods
    @objc func goToNextPage() {
        if currentPage + 1 < onboardingPages.count {
            currentPage += 1
            pageContainer.setViewControllers([onboardingPagesViewControllers[currentPage]],
                                             direction: .forward, animated: true, completion: nil)
            pageController.currentPage = currentPage
            
            if currentPage == onboardingPages.count - 1 {
                nextButton.isHidden = true
                skipButton.isHidden = true
                getStartedButton.isHidden = false
            } else {
                nextButton.isHidden = false
                skipButton.isHidden = false
                getStartedButton.isHidden = true
            }
        }
        
    }
    
    @objc func skipBoarding() {
        let userdefaults = UserDefaults.standard
        userdefaults.set(false, forKey: Constants.isFirstTime)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .white
    }
    
    private func createOnboardingData() {
        
        guard let imageOne = UIImage(named: Constants.boardOne),
              let imageTwo = UIImage(named: Constants.boardTwo),
              let imageThree = UIImage(named: Constants.boardTri) else { return }
        let firstPage = BoardPageHelper(image: imageOne, title: Constants.boardTitleOne,
                                        description: Constants.boardDescOne)
        let secondPage = BoardPageHelper(image: imageTwo, title: Constants.boardTitleTwo,
                                         description: Constants.boardDescTwo)
        let thirdPage = BoardPageHelper(image: imageThree, title: Constants.boardTitleThree,
                                        description: Constants.boardDescThree)
        
        onboardingPages.append(firstPage)
        onboardingPages.append(secondPage)
        onboardingPages.append(thirdPage)
        
        for page in onboardingPages {
            onboardingPagesViewControllers.append(BoardingPageViewController(withPage: page))
        }
        setupPageViewController()
    }
    
    private func setupPageViewController() {
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,
                                             options: [UIPageViewController.OptionsKey.interPageSpacing: 0])
        pageContainer.dataSource = self
        pageContainer.delegate = self
        pageContainer.setViewControllers([onboardingPagesViewControllers[0]],
                                         direction: .forward, animated: true, completion: nil)
        pageContainer.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        addChild(pageContainer)
        view.addSubview(pageContainer.view)
        pageContainer.didMove(toParent: self)
        
        addButtons()
        addCustomPageController()
    }
    
    private func addButtons() {
        pageContainer.view.addSubview(nextButton)
        nextButton.frame = CGRect(x: 0, y: pageContainer.view.frame.height - 65, width: 50, height: 30)
        nextButton.center.x = (pageContainer.view.frame.width / 4) * 3
        nextButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        
        pageContainer.view.addSubview(skipButton)
        skipButton.frame = CGRect(x: 0, y: pageContainer.view.frame.height - 65, width: 50, height: 30)
        skipButton.center.x = (pageContainer.view.frame.width / 4)
        skipButton.addTarget(self, action: #selector(skipBoarding), for: .touchUpInside)
        
        pageContainer.view.addSubview(getStartedButton)
        getStartedButton.frame = CGRect(x: 0, y: pageContainer.view.frame.height - 65, width: 180, height: 30)
        getStartedButton.center.x = (pageContainer.view.frame.width / 2)
        getStartedButton.addTarget(self, action: #selector(skipBoarding), for: .touchUpInside)
    }
    
    private func addCustomPageController() {
        view.bringSubviewToFront(pageController)
        pageController.backgroundColor = .white
        pageController.numberOfPages = onboardingPages.count
        pageController.currentPage = 0
        
        for view in pageContainer.view.subviews {
            if view.isKind(of: UIPageControl.self) {
                if let pp = view as? UIPageControl {
                    pageController = pp

                }
            }
        }
        
        pageController.isEnabled = false
        pageController.pageIndicatorTintColor = .gray
        pageController.currentPageIndicatorTintColor = .systemBlue
    }
}

/// UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension OnBoardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard viewController is BoardingPageViewController else { return nil}
                if let vc = viewController as? BoardingPageViewController {
                    if let index = onboardingPagesViewControllers.firstIndex(of: vc) {
                        if index > 0 {
                        return onboardingPagesViewControllers[index - 1]
                        }
                    }
                }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard viewController is BoardingPageViewController else { return nil}
        if let vc = viewController as? BoardingPageViewController {
            if let index = onboardingPagesViewControllers.firstIndex(of: vc) {
                if index < onboardingPagesViewControllers.count - 1 {
                return onboardingPagesViewControllers[index + 1]
                }
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingPagesViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {

        guard let vc = pendingViewControllers[0] as? BoardingPageViewController,
              let index = onboardingPagesViewControllers.firstIndex(of: vc) else { return }
        currentPage = index
        if currentPage == onboardingPages.count - 1 {
            nextButton.isHidden = true
            skipButton.isHidden = true
            getStartedButton.isHidden = false
        } else {
            nextButton.isHidden = false
            skipButton.isHidden = false
            getStartedButton.isHidden = true
        }
    }
}
