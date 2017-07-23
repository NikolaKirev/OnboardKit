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
	
	lazy var onboardingSlides: [OnboardPage] = {
		let slideOne = OnboardPage(title: NSLocalizedString("Welcome to OnboardKit", comment: ""),
		                           imageName: "Onboarding1",
		                           description: NSLocalizedString("Habitat is an easy to use productivity app designed to keep you motivated.", comment: ""))
		
		let slideTwo = OnboardPage(title: NSLocalizedString("Habit Entries", comment: ""),
		                           imageName: "Onboarding2",
		                           description: NSLocalizedString("For each of your habits an entry is created for every day you need to complete it.", comment: ""))
		
		let slideThree = OnboardPage(title: NSLocalizedString("Marking and Tracking", comment: ""),
		                             imageName: "Onboarding3",
		                             description: NSLocalizedString("By marking entries as Done you can track your progress on the path to success.", comment: ""))
		
		let slideFour = OnboardPage(title: NSLocalizedString("Notifications", comment: ""),
		                            imageName: "Onboarding4",
		                            description: NSLocalizedString("Turn on notifications to get reminders and keep up with your goals.", comment: ""),
		                            actionButtonTitle: NSLocalizedString("Enable Notifications", comment: ""),
		                            advanceButtonTitle: NSLocalizedString("Decide Later", comment: ""))
		
		let slideFive = OnboardPage(title: NSLocalizedString("All Ready", comment: ""),
		                            imageName: "Onboarding5",
		                            description: NSLocalizedString("You are all set up and ready to use Habitat. Begin by adding your first habit.", comment: ""),
		                            advanceButtonTitle: NSLocalizedString("Done", comment: ""))
		
		return [slideOne, slideTwo, slideThree, slideFour, slideFive]
	}()
	
	@IBAction func showOnboardingTapped(_ sender: Any) {
		let onboardingVC = OnboardViewController(slideItems: onboardingSlides)
		self.present(onboardingVC, animated: true, completion: nil)
	}
}
