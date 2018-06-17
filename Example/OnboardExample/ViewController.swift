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

  @IBAction func showOnboardingTapped(_ sender: Any) {
    let onboardingVC = OnboardViewController(pageItems: onboardingPages)
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
