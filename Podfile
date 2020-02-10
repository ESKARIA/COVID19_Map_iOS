# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def firebase
  
  pod 'Fabric', :inhibit_warnings => true
  pod 'Crashlytics', :inhibit_warnings => true
  
  pod 'Firebase', :inhibit_warnings => true
  pod 'Firebase/Auth', :inhibit_warnings => true
  pod 'Firebase/Messaging', :inhibit_warnings => true
  pod 'Firebase/Performance', :inhibit_warnings => true
  
  pod 'GoogleMaps', :inhibit_warnings => true
  pod 'GooglePlaces', :inhibit_warnings => true
  
end

def modules
  
  pod 'DevHelper', :path => 'Frameworks/DevHelper', :inhibit_warnings => true
  pod 'EKNetworking', :path => 'Frameworks/EKNetworking', :inhibit_warnings => true
  
end

target 'NCOVMap' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  firebase
  modules
  # Pods for NCOVMap
  pod 'SnapKit', '~> 5.0.0', :inhibit_warnings => true
  pod 'R.swift', :inhibit_warnings => true

  
  target 'NCOVMapTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'NCOVMapUITests' do
    # Pods for testing
  end
  
end
