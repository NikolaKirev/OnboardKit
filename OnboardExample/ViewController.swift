//
//  ViewController.swift
//  OnboardExample
//
//  Created by Nikola Kirev on 22/07/2017.
//  Copyright © 2017 Nikola Kirev. All rights reserved.
//

import UIKit
import OnboardKit

class ViewController: UIViewController {

	@IBAction func showOnboardingTapped(_ sender: Any) {
		let onboardingVC = OnboardViewController(slideItems: OnboardSlidesHelper.onboardingSlides())
		self.present(onboardingVC, animated: true, completion: nil)
	}
}

