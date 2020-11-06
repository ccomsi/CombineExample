# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
inhibit_all_warnings!

source 'https://cdn.cocoapods.org/'

target 'CombineExample' do
  
  use_frameworks!
  # Pods for CombineExample
  pod 'OpenCombine',              '~> 0.11'
  pod 'OpenCombineDispatch',      '~> 0.11'
  pod 'OpenCombineFoundation',    '~> 0.11'
  pod 'Texture',                  :git => 'https://github.com/TextureGroup/Texture.git',      :branch => 'releases/p8.38'
  pod 'Texture/IGListKit',        :git => 'https://github.com/TextureGroup/Texture.git',      :branch => 'releases/p8.38'
  pod 'TextureSwiftSupport',      '~> 3.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire', '~> 5.0.0-rc.3'
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
