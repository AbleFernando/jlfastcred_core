Pod::Spec.new do |s|
    s.name                  = 'jlfastcred'
    s.version               = '0.0.1'
    s.summary               = 'A Flutter plugin for jlfastcred.'
    s.description           = <<-DESC
    A flutter plugin to show native file picker dialogs.
                           DESC
    s.homepage              = 'https://github.com/AbleFernando/jlfastcredcore'
    s.license               = { :file => '../LICENSE' }
    s.author                = { 'Fernand M Souza' => 'fernando.souza@eabletecbrasil.com' }
    s.source                = { :path => '.' }
    s.source_files          = 'Classes/**/*'
    s.public_header_files   = 'Classes/**/*.h'
    s.dependency       'Flutter'
    
    s.ios.deployment_target = '11.0'
  
    # Flutter engine and framework
    # flutter_root = `flutter --version`.match(/Flutter (.*?) /)[1]
    # s.xcconfig = { 'FLUTTER_ROOT' => "#{flutter_root}/flutter" }
  end
