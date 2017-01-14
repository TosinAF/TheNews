source 'https://github.com/CocoaPods/Specs'

use_frameworks!

platform :ios, '10.0'

def debug_pods
    pod 'Reveal-SDK', :configurations => ['Debug']
end

def external_pods
    pod 'pop'
    pod 'Moya', '8.0.0'
    pod 'SwiftyJSON', '3.1.4'
    pod 'Cartography', '1.0.1'
    pod 'Anchorage', '3.0.0'
    pod 'Heimdallr', git: 'https://github.com/marcelofabri/Heimdallr.swift.git', branch: 'swift-3.0'
    pod 'JTHamburgerButton'
    pod 'libHN', '~> 4.1'

end

target 'TheNews' do
    debug_pods
    external_pods
end

inhibit_all_warnings!
