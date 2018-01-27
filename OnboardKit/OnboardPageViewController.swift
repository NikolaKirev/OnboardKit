//
//  OnboardSlideViewController.swift
//  OnboardKit
//
//  Created by Nikola Kirev on 22/07/2017.
//

import UIKit

protocol OnboardPageViewControllerDelegate: class {
  
  func slideViewControllerDidSelectActionButton(slideVC: OnboardPageViewController)
  
  func slideViewControllerDidSelectAdvanceButton(slideVC: OnboardPageViewController)
}

final class OnboardPageViewController: UIViewController {
  
  private let defaultSpacing: CGFloat = 16.0

  private lazy var slideStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 16.0
    stackView.axis = .vertical
    stackView.alignment = .center
    return stackView
  }()
  
  private lazy var slideTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var slideImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .center
    return imageView
  }()
  
  private lazy var slideDescriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  private lazy var slideActionButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    button.setTitleColor(UIColor.blue, for: .normal)
    return button
  }()
  
  private lazy var slideAdvanceButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    button.setTitleColor(UIColor.blue, for: .normal)
    return button
  }()
  
  var slideIndex: Int
  
  weak var delegate: OnboardPageViewControllerDelegate?
  
  init(slideIndex: Int, appearanceConfiguration: OnboardPage.AppearanceConfiguration? = nil) {
    self.slideIndex = slideIndex
    super.init(nibName: nil, bundle: nil)
    customizeStyleWith(appearanceConfiguration)
//    customizeForDebug()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func customizeStyleWith(_ appearanceConfiguration: OnboardPage.AppearanceConfiguration?) {
    view.backgroundColor = .white
  }
  
  private func customizeForDebug() {
    view.backgroundColor = .green
    slideStackView.backgroundColor = .yellow
    slideImageView.backgroundColor = .purple
    slideDescriptionLabel.backgroundColor = .orange
    slideActionButton.backgroundColor = .cyan
    slideAdvanceButton.backgroundColor = .brown
  }
  
  override func loadView() {
    super.loadView()
    view.addSubview(slideTitleLabel)
    view.addSubview(slideStackView)
    slideTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    if #available(iOS 11.0, *) {
      slideTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
      slideStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
      slideStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
      slideStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    } else {
      // Fallback on earlier versions
      slideTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0).isActive = true
      slideStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      slideStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      slideStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    slideStackView.topAnchor.constraint(equalTo: slideTitleLabel.bottomAnchor, constant: 16.0).isActive = true
    slideStackView.addArrangedSubview(slideImageView)
    slideStackView.addArrangedSubview(slideDescriptionLabel)
    slideStackView.addArrangedSubview(slideActionButton)
    slideStackView.addArrangedSubview(slideAdvanceButton)
    
    slideActionButton.addTarget(self,
                                action: #selector(OnboardPageViewController.actionTapped),
                                for: .touchUpInside)
    slideAdvanceButton.addTarget(self,
                                 action: #selector(OnboardPageViewController.advanceTapped),
                                 for: .touchUpInside)
  }
  
  func configureWithSlide(_ slide: OnboardPage) {
    configureTitleLabel(slide.title)
    configureImageView(slide.imageName)
    configureDescriptionLabel(slide.description)
    configureActionButton(slide.actionButtonTitle, action: slide.action)
    configureAdvanceButton(slide.advanceButtonTitle)
  }
  
  private func configureTitleLabel(_ title: String) {
    slideTitleLabel.text = title
  }

  private func configureImageView(_ imageName: String?) {
    if let imageName = imageName, let image = UIImage(named: imageName) {
      slideImageView.image = image
      slideImageView.heightAnchor.constraint(equalTo: slideStackView.heightAnchor, multiplier: 0.4).isActive = true
    } else {
      slideImageView.isHidden = true
    }
  }

  private func configureDescriptionLabel(_ description: String?) {
    if let slideDescription = description {
      slideDescriptionLabel.text = slideDescription
      slideDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualTo: slideStackView.heightAnchor, multiplier: 0.3).isActive = true
      slideDescriptionLabel.widthAnchor.constraint(equalTo: slideStackView.widthAnchor, multiplier: 0.8).isActive = true
    } else {
      slideDescriptionLabel.isHidden = true
    }
  }

  private func configureActionButton(_ title: String?, action: OnboardPageAction?) {
    if let actionButtonTitle = title {
      slideActionButton.setTitle(actionButtonTitle, for: .normal)
    } else {
      slideActionButton.isHidden = true
    }
  }

  private func configureAdvanceButton(_ title: String) {
    slideAdvanceButton.setTitle(title, for: .normal)
  }

  // MARK - User Actions
  @objc fileprivate func actionTapped() {
    delegate?.slideViewControllerDidSelectActionButton(slideVC: self)
  }
  
  @objc fileprivate func advanceTapped() {
    delegate?.slideViewControllerDidSelectAdvanceButton(slideVC: self)
  }
}
