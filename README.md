![OnboardKit](Assets/banner.png)

# OnboardKit
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Twitter](https://img.shields.io/badge/twitter-@NikolaKirev-blue.svg?style=flat)](https://twitter.com/NikolaKirev)

*Customisable user onboarding for your iOS app in Swift*

<p align="center"><img src="https://github.com/NikolaKirev/OnboardKit/develop/Assets/demo.gif" /></p>

## Requirements

* Swift 4.0
* Xcode 9
* iOS 10.0+

## Installation

#### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "NikolaKirev/OnboardKit"
````

Don't forget to `import OnboardKit` in the file you intend to use it.

## Usage

1. Create and populate a bunch of `OnboardPage` instances
````swift
let page = OnboardPage(title: "Welcome to OnboardKit",
                       imageName: "Onboarding1",
                       description: "OnboardKit helps you add onboarding to your iOS app")
````
2. Create an `OnboardViewController`
````swift
let onboardingViewController = OnboardViewController(pageItems: [pageOne, ...]])
````
3. Present the view controller
````swift
onboardingVC.presentFrom(self, animated: true)
````
(use this convenience method to make sure you predent it modally)

## Customizatioon

You can customize the look of your onboarding by changing the default colors.
````swift
AppearanceConfiguration(tintColor: .green,
                        textColor: .white,
                        backgroundColor: .black,
                        titleFont: UIFont.boldSystemFont(ofSize: 24),
                        textFont: UIFont.boldSystemFont(ofSize: 13))
````

## Author

[Nikola Kirev](http://nikolakirev.com)

[@NikolaKirev](http://twitter.com/nikolakirev)

## License

OnboardKit is available under the MIT license. See the LICENSE file for more info.
