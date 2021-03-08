# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
inhibit_all_warnings!

source 'https://cdn.cocoapods.org/'

target 'CombineExample' do
  
  use_frameworks!
  # Pods for CombineExample
  pod 'OpenCombine',              '~> 0.12'
  pod 'OpenCombineDispatch',      '~> 0.12'
  pod 'OpenCombineFoundation',    '~> 0.12'
  pod 'Texture',                  :git => 'https://github.com/TextureGroup/Texture.git',      :branch => 'releases/p9.7'
  pod 'TextureSwiftSupport'
  pod 'DiffableDataSources'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire'
  target 'CombineExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each { |target|
        target.build_configurations.each { |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        }
    }
end
