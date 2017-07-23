//
//  OnboardSlideViewController.swift
//  OnboardKit
//
//  Created by Nikola Kirev on 22/07/2017.
//

import UIKit

protocol OnboardPageViewControllerDelegate: class {

	func slideViewControllerDidSelectActionButton(_ slideVC: OnboardPageViewController)

	func slideViewControllerDidSelectAdvanceButton(_ slideVC: OnboardPageViewController)
}

final class OnboardPageViewController: UIViewController {

	private lazy var slideStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		return stackView
	}()

	private lazy var slideTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title1)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var slideImageView: UIImageView = {
		return UIImageView()
	}()
	
	private lazy var slideDescriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()
	
	private lazy var slideActionButton: UIButton = {
		return UIButton()
	}()
	
	private lazy var slideAdvanceButton: UIButton = {
		return UIButton()
	}()

	var slideIndex: Int

	weak var delegate: OnboardPageViewControllerDelegate?

	init(slideIndex: Int) {
		self.slideIndex = slideIndex
		super.init(nibName: nil, bundle: nil)
		view.backgroundColor = .green
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		
		view.addSubview(slideStackView)
		slideStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		slideStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		slideStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		slideStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		
		slideStackView.addArrangedSubview(slideTitleLabel)
		slideStackView.addArrangedSubview(slideDescriptionLabel)

		slideActionButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
		slideActionButton.tintColor = UIColor.blue
		slideActionButton.backgroundColor = UIColor.blue
		slideActionButton.addTarget(self,
		                            action: #selector(OnboardPageViewController.actionTapped),
		                            for: .touchUpInside)

		slideAdvanceButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
		slideAdvanceButton.setTitleColor(UIColor.blue, for: .normal)
		slideAdvanceButton.addTarget(self,
		                            action: #selector(OnboardPageViewController.advanceTapped),
		                            for: .touchUpInside)
	}

	func configureWithSlide(_ slide: OnboardPage) {
		slideTitleLabel.text = slide.title
		if let imageName = slide.imageName {
			slideImageView.image = UIImage(named: imageName)
		} else {
			slideImageView.isHidden = true
		}
		if let slideDescription = slide.description {
			slideDescriptionLabel.text = slideDescription
		} else {
			slideDescriptionLabel.isHidden = true
		}
		if let actionButtonTitle = slide.actionButtonTitle {
			slideActionButton.setTitle(actionButtonTitle, for: .normal)
		} else {
			slideActionButton.isHidden = true
		}
		slideAdvanceButton.setTitle(slide.advanceButtonTitle, for: .normal)
	}

	@objc fileprivate func actionTapped() {
		delegate?.slideViewControllerDidSelectActionButton(self)
	}

	@objc fileprivate func advanceTapped() {
		delegate?.slideViewControllerDidSelectAdvanceButton(self)
	}
}
