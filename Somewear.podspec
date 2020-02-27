
Pod::Spec.new do |s|
  s.name             = 'Somewear'
  s.version          = '0.2.0'
  s.summary          = 'Somewear SDK'
  s.homepage         = 'https://github.com/someweardev/somewear-ios'
  s.license = { :type => 'Commercial', :text => 'Created and licensed by Somewear Labs. Copyright 2019 Somewear Labs, Inc. All rights reserved.' }
  s.author           = { 'someweardev' => 'someweardev@gmail.com' }
  s.source           = { :git => 'https://github.com/someweardev/somewear-ios.git', :tag => s.version.to_s }
  s.platform         = :ios, '10.0'
  s.swift_version    = '5.1'

  s.subspec 'Core' do |ss|
      ss.platform     = :ios, '10.0'
      ss.ios.vendored_frameworks = 'Somewear/SomewearCore.xcframework'
      ss.preserve_paths = 'Somewear/SomewearCore.xcframework'
      ss.dependency 'iOSDFULibrary', '~> 4.6.1'
      ss.dependency 'libPhoneNumber-iOS', '~> 0.9.15'
      ss.dependency 'PromisesSwift', '~> 1.2.8'
      ss.dependency 'SwiftProtobuf', '~> 1.7.0'
      ss.dependency 'RxSwift', '~> 5.0.1'
      ss.frameworks = 'CoreBluetooth'
  end
  
  s.subspec 'UI' do |ss|
      ss.platform     = :ios, '10.0'
      ss.ios.vendored_frameworks = 'Somewear/SomewearUI.xcframework'
      ss.preserve_paths = 'Somewear/SomewearUI.xcframework'
      ss.dependency 'Somewear/Core'
      ss.dependency 'MaterialComponents/Buttons', '~> 81.0.0'
      ss.dependency 'MaterialComponents/Cards', '~> 81.0.0'
      ss.dependency 'MaterialComponents/FeatureHighlight', '~> 81.0.0'
      ss.dependency 'MaterialComponents/schemes/Color', '~> 81.0.0'
      ss.dependency 'MaterialComponents/ShadowLayer', '~> 81.0.0'
      ss.dependency 'MaterialComponents/ShapeLibrary', '~> 81.0.0'
      ss.dependency 'MaterialComponents/Snackbar', '~> 81.0.0'
      ss.dependency 'MaterialComponents/Snackbar+ColorThemer', '~> 81.0.0'
      ss.dependency 'MaterialComponents/Tabs', '~> 81.0.0'
      ss.frameworks = 'UIKit'
  end
  
end
