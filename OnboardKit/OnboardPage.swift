//
//  OnboardPage.swift
//  OnboardKit
//
//  Created by Nikola Kirev on 22/07/2017.
//

import Foundation

public typealias OnboardPageCompletion = ((_ success: Bool, _ error: Error?) -> Void)
public typealias OnboardPageAction = (@escaping OnboardPageCompletion) -> Void

public struct OnboardPage {
  let title: String
  let imageName: String?
  let description: String?
  let actionButtonTitle: String?
  let advanceButtonTitle: String
  let action: OnboardPageAction?
  
  public init(title: String,
              imageName: String? = nil,
              description: String?,
              actionButtonTitle: String? = nil,
              advanceButtonTitle: String = NSLocalizedString("Next", comment: ""),
              action: OnboardPageAction? = nil) {
    self.title = title
    self.imageName = imageName
    self.description = description
    self.actionButtonTitle = actionButtonTitle
    self.advanceButtonTitle = advanceButtonTitle
    self.action = action
  }
}
