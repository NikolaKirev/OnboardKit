//
//  ViewController.swift
//  OnboardExample
//

import UIKit
import OnboardKit

class ViewController: UIViewController {

  lazy var onboardingPages: [OnboardPage] = {
    let pageOne = OnboardPage(title: "Welcome to Habitat",
                              imageName: "Onboarding1",
                              description: "Habitat is an easy to use productivity app designed to keep you motivated.")

    let pageTwo = OnboardPage(title: "Habit Entries",
                              imageName: "Onboarding2",
      description: "For each of your habits an entry is created for every day you need to complete it.")

    let pageThree = OnboardPage(title: "Marking and Tracking",
                                imageName: "Onboarding3",
      description: "By marking entries as Done you can track your progress on the path to success.")

    let pageFour = OnboardPage(title: "Notifications",
                               imageName: "Onboarding4",
                               description: "Turn on notifications to get reminders and keep up with your goals.",
                               advanceButtonTitle: "Decide Later",
                               actionButtonTitle: "Enable Notifications",
                               action: { [weak self] completion in
                                self?.showAlert(completion)
    })

    let pageFive = OnboardPage(title: "All Ready",
                               imageName: "Onboarding5",
      description: "You are all set up and ready to use Habitat. Begin by adding your first habit.",
      advanceButtonTitle: "Done")

    return [pageOne, pageTwo, pageThree, pageFour, pageFive]
  }()

  lazy var onboardingPagesAlternative: [OnboardPage] = {
    let pageOne = OnboardPage(title: "Welcome to Habitat",
                              imageName: "Onboarding1_alt",
                              description: "Habitat is an easy to use productivity app designed to keep you motivated.")

    let pageTwo = OnboardPage(title: "Habit Entries",
                              imageName: "Onboarding2",
                              description: "For each of your habits an entry is created for every day you need to complete it.")

    let pageThree = OnboardPage(title: "Marking and Tracking",
                                imageName: "Onboarding3",
                                description: "By marking entries as Done you can track your progress on the path to success.")

    let pageFour = OnboardPage(title: "Notifications",
                               imageName: "Onboarding4",
                               description: "Turn on notifications to get reminders and keep up with your goals.",
                               advanceButtonTitle: "Decide Later",
                               actionButtonTitle: "Enable Notifications",
                               action: { [weak self] completion in
                                self?.showAlert(completion)
    })

    let pageFive = OnboardPage(title: "All Ready",
                               imageName: "Onboarding5",
                               description: "You are all set up and ready to use Habitat. Begin by adding your first habit.",
                               advanceButtonTitle: "Done")

    return [pageOne, pageTwo, pageThree, pageFour, pageFive]
  }()

  @IBAction func showOnboardingDefaultTapped(_ sender: Any) {
    let onboardingVC = OnboardViewController(pageItems: onboardingPages)
    onboardingVC.modalPresentationStyle = .formSheet
    onboardingVC.presentFrom(self, animated: true)
  }

  @IBAction func showOnboardingCustomTapped(_ sender: Any) {
    let tintColor = UIColor(red: 1.00, green: 0.52, blue: 0.40, alpha: 1.00)
    let titleColor = UIColor(red: 1.00, green: 0.35, blue: 0.43, alpha: 1.00)
    let boldTitleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
    let mediumTextFont = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    let appearanceConfiguration = OnboardViewController.AppearanceConfiguration(tintColor: tintColor,
                                                                                titleColor: titleColor,
                                                                                textColor: .white,
                                                                                backgroundColor: .black,
                                                                                titleFont: boldTitleFont,
                                                                                textFont: mediumTextFont)
    let onboardingVC = OnboardViewController(pageItems: onboardingPagesAlternative,
                                             appearanceConfiguration: appearanceConfiguration)
    onboardingVC.modalPresentationStyle = .formSheet
    onboardingVC.presentFrom(self, animated: true)
  }

  @IBAction func showOnboardingStyledButtonsTapped(_ sender: Any) {
    let advanceButtonStyling: OnboardViewController.ButtonStyling = { button in
      button.setTitleColor(UIColor.lightGray, for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }
    let actionButtonStyling: OnboardViewController.ButtonStyling = { button in
      button.setTitleColor(.black, for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
      button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
      button.layer.cornerRadius = button.bounds.height / 2.0
      button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
      button.layer.shadowColor = UIColor.black.cgColor
      button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
      button.layer.shadowRadius = 2.0
      button.layer.shadowOpacity = 0.2
    }
    let appearance = OnboardViewController.AppearanceConfiguration(advanceButtonStyling: advanceButtonStyling,
                                                                    actionButtonStyling: actionButtonStyling)
    let onboardingVC = OnboardViewController(pageItems: onboardingPages,
                                             appearanceConfiguration: appearance)
    onboardingVC.modalPresentationStyle = .formSheet
    onboardingVC.presentFrom(self, animated: true)
  }

  /// Only for the purpouses of the example.
  /// Not really asking for notifications permissions.
  private func showAlert(_ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
    let alert = UIAlertController(title: "Allow Notifications?",
                                  message: "Habitat wants to send you notifications",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      completion(true, nil)
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
      completion(false, nil)
    })
    presentedViewController?.present(alert, animated: true)
  }
}
