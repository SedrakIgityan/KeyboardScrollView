#
# Be sure to run `pod lib lint KeyboardScrollView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KeyboardScrollView'
  s.version          = '0.1.0'
  s.summary          = 'Textfield with keyboard scroll'
  s.swift_versions  = '5'

  s.description      = <<-DESC
Scroll view is responsible to create generic layer to automatically perform scroll when textfield is covered with keyboard.
DESC

  s.homepage         = 'https://github.com/SedrakIgityan/KeyboardScrollView.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sedrakigityan2000@gmail.com' => 'sedrakigityan2000@gmail.com' }
  s.source           = { :git => 'https://github.com/SedrakIgityan/KeyboardScrollView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'KeyboardScrollView/KeyboardScrollView/**/*'
  s.exclude_files = "KeyboardScrollView/KeyboardScrollView/*.plist"
  s.module_name = 'KeyboardScrollView'
end
