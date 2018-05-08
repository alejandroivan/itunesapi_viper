# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'itunesapi' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for itunesapi
  pod 'Alamofire', '~> 4.7' # Conectividad
  pod 'AlamofireImage', '~> 3.3' # Carga asíncrona de imágenes en UIImageView


  target 'itunesapiTests' do
    inherit! :search_paths
    # Pods for testing
  end

end


## Post install hook
post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0' # Compilar Pods con deployment target 10.0
#            config.build_settings['SWIFT_VERSION'] = '4.0' # Forzar pods a compilar con Swift 4
        end
    end
end
