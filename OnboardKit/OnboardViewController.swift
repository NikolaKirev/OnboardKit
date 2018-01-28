//
//  OnboardViewController.swift
//  OnboardKit
//
//  Created by Nikola Kirev on 22/07/2017.
//

import UIKit

final public class OnboardViewController: UIViewController {
  
  fileprivate let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                            navigationOrientation: .horizontal,
                                                            options: nil)
  fileprivate var slideItems: [OnboardPage]
  
  private let appearanceConfiguration: AppearanceConfiguration
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public init(slideItems: [OnboardPage],
              appearanceConfiguration: AppearanceConfiguration = AppearanceConfiguration()) {
    self.slideItems = slideItems
    self.appearanceConfiguration = appearanceConfiguration
    super.init(nibName: nil, bundle: nil)
  }

  override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }

  override public func loadView() {
    super.loadView()
    view.backgroundColor = appearanceConfiguration.backgroundColor
    pageViewController.setViewControllers([slideViwControllerFor(slideIndex: 0)!],
                                          direction: .forward,
                                          animated: false,
                                          completion: nil)
    pageViewController.dataSource = self
    pageViewController.delegate = self
    pageViewController.view.frame = view.bounds
    
    let pageControlApperance = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardViewController.self])
    pageControlApperance.pageIndicatorTintColor = appearanceConfiguration.tintColor.withAlphaComponent(0.3)
    pageControlApperance.currentPageIndicatorTintColor = appearanceConfiguration.tintColor
    
    addChildViewController(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParentViewController: self)
  }
  
  fileprivate func slideViwControllerFor(slideIndex: Int) -> OnboardPageViewController? {
    let slideVC = OnboardPageViewController(slideIndex: slideIndex, appearanceConfiguration: appearanceConfiguration)
    guard slideIndex >= 0 else { return nil }
    guard slideIndex < slideItems.count else { return nil }
    slideVC.delegate = self
    slideVC.configureWithSlide(slideItems[slideIndex])
    return slideVC
  }
  
  fileprivate func advanceToSlideWithIndex(slideIndex: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let nextSlide = self?.slideViwControllerFor(slideIndex: slideIndex) else { return }
      self?.pageViewController.setViewControllers([nextSlide],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
    }
  }
}

// MARK: Presenting
public extension OnboardViewController {

  public func presentFrom(_ viewController: UIViewController, animated: Bool) {
    viewController.present(self, animated: animated)
  }
}

extension OnboardViewController: UIPageViewControllerDataSource {
  
  public func pageViewController(_ pageViewController: UIPageViewController,
                                 viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let slideVC = viewController as? OnboardPageViewController else { return nil }
    let slideIndex = slideVC.slideIndex
    guard slideIndex != 0 else { return nil }
    return slideViwControllerFor(slideIndex: slideIndex - 1)
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController,
                                 viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let slideVC = viewController as? OnboardPageViewController else { return nil }
    let slideIndex = slideVC.slideIndex
    return slideViwControllerFor(slideIndex: slideIndex + 1)
  }
  
  public func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return slideItems.count
  }
  
  public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    if let currentSlide = pageViewController.viewControllers?.first as? OnboardPageViewController {
      return currentSlide.slideIndex
    }
    return 0
  }
}

extension OnboardViewController: UIPageViewControllerDelegate {
  
}

extension OnboardViewController: OnboardPageViewControllerDelegate {

  func slideViewControllerDidSelectActionButton(slideVC: OnboardPageViewController) {
    let slideIndex = slideVC.slideIndex
    if let slideAction = slideItems[slideIndex].action {
      slideAction({ (success, error) in
        guard error == nil else { return }
        if success {
          self.advanceToSlideWithIndex(slideIndex: slideIndex+1)
        }
      })
    }
  }

  func slideViewControllerDidSelectAdvanceButton(slideVC: OnboardPageViewController) {
    let slideIndex = slideVC.slideIndex
    if slideIndex == slideItems.count-1 {
      dismiss(animated: true, completion: nil)
    } else {
      advanceToSlideWithIndex(slideIndex: slideIndex+1)
    }
  }
}

extension OnboardViewController {
  public struct AppearanceConfiguration {
    let tintColor: UIColor
    let textColor: UIColor
    let backgroundColor: UIColor
    
    let titleFont: UIFont
    let textFont: UIFont
    
    public init(tintColor: UIColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0),
                textColor: UIColor = .black,
                backgroundColor: UIColor = .white,
                titleFont: UIFont = UIFont.preferredFont(forTextStyle: .title1),
                textFont: UIFont = UIFont.preferredFont(forTextStyle: .body)) {
      self.tintColor = tintColor
      self.textColor = textColor
      self.backgroundColor = backgroundColor
      self.titleFont = titleFont
      self.textFont = textFont
    }
  }
}

