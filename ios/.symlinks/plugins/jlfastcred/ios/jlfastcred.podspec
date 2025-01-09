Pod::Spec.new do |s|
    s.name             = 'jlfastcred'
    s.version          = '1.0.0'
    s.summary          = 'A Flutter plugin for jlfastcred.'
    s.homepage         = 'https://github.com/AbleFernando/jlfastcredcore'
    s.license          = { :file => '../LICENSE' }
    s.author           = { 'Fernand M Souza' => 'fernando.souza@eabletecbrasil.com' }
    s.source           = { :path => '.' }
    s.source_files     = 'Classes/**/*'
    s.dependency       'Flutter'
    s.platform         = :ios, '11.0'
  
    # Flutter engine and framework
    flutter_root = `flutter --version`.match(/Flutter (.*?) /)[1]
    s.xcconfig = { 'FLUTTER_ROOT' => "#{flutter_root}/flutter" }
  end
  