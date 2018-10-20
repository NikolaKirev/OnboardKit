//
//  AppearanceConfigurationTests.swift
//  OnboardKitTests
//

import XCTest
@testable import OnboardKit

final class AppearanceConfigurationTests: XCTestCase {

  func testAppearanceConfiguration_usesSpecificColor_whenTitleColorSpecified() {
    let sut = OnboardViewController.AppearanceConfiguration(titleColor: .purple, textColor: .green)
    XCTAssertNotEqual(sut.titleColor, .green)
    XCTAssertEqual(sut.titleColor, .purple)
  }

  func testAppearanceConfiguration_usesTextColor_whenTitleColorNotSpecified() {
    let sut = OnboardViewController.AppearanceConfiguration(textColor: .green)
    XCTAssertEqual(sut.titleColor, .green)
  }
}
