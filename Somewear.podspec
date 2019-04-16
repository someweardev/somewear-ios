
Pod::Spec.new do |s|
  s.name             = 'Somewear'
  s.version          = '0.1.2'
  s.summary          = 'Somewear SDK'
  s.homepage         = 'https://github.com/someweardev/somewear-ios'
  s.license = { :type => 'Commercial', :text => 'Created and licensed by Somewear Labs. Copyright 2019 Somewear Labs, Inc. All rights reserved.' }
  s.author           = { 'someweardev' => 'someweardev@gmail.com' }
  s.source           = { :git => 'https://github.com/someweardev/somewear-ios.git', :tag => s.version.to_s }
  s.platform         = :ios, '10.0'
  s.swift_version    = '5.0'

  s.subspec 'Core' do |ss|
      ss.platform     = :ios, '10.0'
      ss.ios.vendored_frameworks = 'Somewear/SomewearCore.framework'
      ss.preserve_paths = 'Somewear/SomewearCore.framework'
      ss.dependency 'libPhoneNumber-iOS', '~> 0.9.13'
      ss.dependency 'PhoneNumberKit', '~> 2.6.0'
      ss.dependency 'PromisesSwift', '~> 1.2.7'
      ss.dependency 'SwiftProtobuf', '~> 1.4.0'
      ss.dependency 'RxSwift', '~> 4.5.0'
      ss.frameworks = 'CoreBluetooth'
  end
  
  # s.resource_bundles = {
  #   'SomewearCore' => ['SomewearCore/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
