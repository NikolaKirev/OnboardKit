Pod::Spec.new do |s|

  s.name         = "OnboardKit"
  s.version      = "1.0.0"
  s.summary      = "Customisable user onboarding for your iOS app"

  s.description  = <<-DESC
    OnboardKit gives you an easy way to add onboarding to your iOS app.
    It is written in Swift.
                   DESC

  s.homepage     = "https://github.com/NikolaKirev/OnboardKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Nikola Kirev" => "nikola@nikolakirev.com" }
  s.social_media_url   = "http://twitter.com/NikolaKirev"

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/NikolaKirev/OnboardKit.git", :tag => "v1.0.0" }
  s.source_files  = "OnboardKit"

end
