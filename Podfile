platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

pod 'Parse'
pod 'ParseCrashReporting'
pod 'PINRemoteImage', :inhibit_warnings => true
pod 'TLYShyNavBar'
pod 'Dollar'
pod 'Cent'
pod 'DateTools'
pod 'Mapbox-iOS-SDK'
pod 'GoogleMaps'

# disable bitcode in every sub-target
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end