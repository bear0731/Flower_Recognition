# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'WhatFlower' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for WhatFlower
    pod 'Alamofire', '~> 4.4.0'
    pod 'SwiftyJSON'
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
            end
        end
    end
end
