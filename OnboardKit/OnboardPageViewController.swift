//
//  OnboardPageViewController.swift
//  OnboardKit
//

import UIKit

internal protocol OnboardPageViewControllerDelegate: class {

  /// Informs the `delegate` that the action button was tapped
  ///
  /// - Parameters:
  ///   - pageVC: The `OnboardPageViewController` object
  ///   - index: The page index
  func pageViewController(_ pageVC: OnboardPageViewController, actionTappedAt index: Int)

  /// Informs the `delegate` that the advance(next) button was tapped
  ///
  /// - Parameters:
  ///   - pageVC: The `OnboardPageViewController` object
  ///   - index: The page index
  func pageViewController(_ pageVC: OnboardPageViewController, advanceTappedAt index: Int)
}

internal final class OnboardPageViewController: UIViewController {

  private lazy var pageStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 16.0
    stackView.axis = .vertical
    stackView.alignment = .center
    return stackView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
    return label
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  private lazy var actionButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    return button
  }()

  private lazy var advanceButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    return button
  }()

  let pageIndex: Int

  weak var delegate: OnboardPageViewControllerDelegate?

  private let appearanceConfiguration: OnboardViewController.AppearanceConfiguration

  init(pageIndex: Int, appearanceConfiguration: OnboardViewController.AppearanceConfiguration) {
    self.pageIndex = pageIndex
    self.appearanceConfiguration = appearanceConfiguration
    super.init(nibName: nil, bundle: nil)
    customizeStyleWith(appearanceConfiguration)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func customizeStyleWith(_ appearanceConfiguration: OnboardViewController.AppearanceConfiguration) {
    view.backgroundColor = appearanceConfiguration.backgroundColor
    // Setup imageView
    imageView.contentMode = appearanceConfiguration.imageContentMode
    // Style title
    titleLabel.textColor = appearanceConfiguration.titleColor
    titleLabel.font = appearanceConfiguration.titleFont
    // Style description
    descriptionLabel.textColor = appearanceConfiguration.textColor
    descriptionLabel.font = appearanceConfiguration.textFont
  }

  private func customizeButtonsWith(_ appearanceConfiguration: OnboardViewController.AppearanceConfiguration) {
    advanceButton.sizeToFit()
    if let advanceButtonStyling = appearanceConfiguration.advanceButtonStyling {
      advanceButtonStyling(advanceButton)
    } else {
      advanceButton.setTitleColor(appearanceConfiguration.tintColor, for: .normal)
      advanceButton.titleLabel?.font = appearanceConfiguration.textFont
    }
    actionButton.sizeToFit()
    if let actionButtonStyling = appearanceConfiguration.actionButtonStyling {
      actionButtonStyling(actionButton)
    } else {
      actionButton.setTitleColor(appearanceConfiguration.tintColor, for: .normal)
      actionButton.titleLabel?.font = appearanceConfiguration.titleFont
    }
  }

  override func loadView() {
    view = UIView(frame: CGRect.zero)
    view.addSubview(titleLabel)
    view.addSubview(pageStackView)
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
      pageStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
      pageStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      pageStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      pageStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
      ])
    pageStackView.addArrangedSubview(imageView)
    pageStackView.addArrangedSubview(descriptionLabel)
    pageStackView.addArrangedSubview(actionButton)
    pageStackView.addArrangedSubview(advanceButton)

    actionButton.addTarget(self,
                           action: #selector(OnboardPageViewController.actionTapped),
                           for: .touchUpInside)
    advanceButton.addTarget(self,
                            action: #selector(OnboardPageViewController.advanceTapped),
                            for: .touchUpInside)

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    customizeButtonsWith(appearanceConfiguration)
  }

  func configureWithPage(_ page: OnboardPage) {
    configureTitleLabel(page.title)
    configureImageView(page.imageName)
    configureDescriptionLabel(page.description)
    configureActionButton(page.actionButtonTitle, action: page.action)
    configureAdvanceButton(page.advanceButtonTitle)
  }

  private func configureTitleLabel(_ title: String) {
    titleLabel.text = title
  }

  private func configureImageView(_ imageName: String?) {
    if let imageName = imageName, let image = UIImage(named: imageName) {
      imageView.image = image
      imageView.heightAnchor.constraint(equalTo: pageStackView.heightAnchor, multiplier: 0.5).isActive = true
    } else {
      imageView.isHidden = true
    }
  }

  private func configureDescriptionLabel(_ description: String?) {
    if let pageDescription = description {
      descriptionLabel.text = pageDescription
      NSLayoutConstraint.activate([
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualTo: pageStackView.heightAnchor, multiplier: 0.2),
        descriptionLabel.widthAnchor.constraint(equalTo: pageStackView.widthAnchor, multiplier: 0.8)
        ])
    } else {
      descriptionLabel.isHidden = true
    }
  }

  private func configureActionButton(_ title: String?, action: OnboardPageAction?) {
    if let actionButtonTitle = title {
      actionButton.setTitle(actionButtonTitle, for: .normal)
    } else {
      actionButton.isHidden = true
    }
  }

  private func configureAdvanceButton(_ title: String) {
    advanceButton.setTitle(title, for: .normal)
  }

  // MARK: - User Actions
  @objc fileprivate func actionTapped() {
    delegate?.pageViewController(self, actionTappedAt: pageIndex)
  }

  @objc fileprivate func advanceTapped() {
    delegate?.pageViewController(self, advanceTappedAt: pageIndex)
  }
}
