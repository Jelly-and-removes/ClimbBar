#
#  Be sure to run `pod spec lint ClimbBar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ClimbBar"
  s.version      = "1.7.0"
  s.summary      = "You can move another object synchronously with the scroll value."
  s.description  = <<-DESC
                    iOS library that can extend a View that has scrollable elements such as UITableView and UIWebView.
                   DESC

  s.homepage     = "https://github.com/keisukeYamagishi/ClimbBar"
  s.license      = "MIT"
  s.author             = { "keisuke" => "jam330157@gmail.com" }
  s.source       = { :git => "https://github.com/keisukeYamagishi/ClimbBar.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files  = "Source", "ClimbBar/*.swift"
end