
Pod::Spec.new do |s|
  s.name             = 'Themer'
  s.version          = '0.1.0'
  s.summary          = 'Theme management solution in Swift that includes light, dark, and system default options.'

  s.description      = <<-DESC
"Provides elgant way to use light and dark themes or opt to whatever the system default is. Makes whole views themable, instead of just colors and images. Allows high customization of view components and puts all theming in one place."
                       DESC

  s.homepage         = 'https://github.com/igniti0n/Themer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'igniti0n' => 'ivanat735@gmail.com' }
  s.source           = { :git => 'https://github.com/igniti0n/Themer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ivanstajcer'
  
  s.ios.deployment_target = '13.0'
  
  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'

end
