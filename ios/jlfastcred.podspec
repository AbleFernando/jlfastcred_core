Pod::Spec.new do |s|
    s.name             = 'jlfastcred'
    s.version          = '1.0.0'
    s.summary          = 'A descrição do pacote'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.source           = { :git => 'https://github.com/AbleFernando/jlfastcredcore.git', :tag => 'v1.0.0' }
    s.platform         = :ios, '11.0'
    s.source_files     = 'ios/**/*.{h,m}'
    s.dependency       'Flutter'
  end
  