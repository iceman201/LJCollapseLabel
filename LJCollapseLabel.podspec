#
# Be sure to run `pod lib lint LJCollapseLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LJCollapseLabel'
  s.version          = '1.1.0'
  s.summary      = "A simple collapse animate effect UI label."
  s.description  = "This framework is a tiny feature that I did in my 2016 project. It's a simple UI setup create the collapse animation effect of the UI Label. Now I would like to share it with all developers around the world."
  s.homepage     = "https://liguo.jiao.co.nz"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Liguo Jiao" => "liguo@jiao.co.nz" }
  s.social_media_url   = "https://twitter.com/jiaoliguo"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/iceman201/LJCollapseLabel.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/LJCollapseLabel/**/*'
  s.private_header_files = 'Sources/LJCollapseLabel/**/GradientBackgroundView.h'
end
