Pod::Spec.new do |spec|
  spec.name = "Core"
  spec.version = '1.0.0'
  spec.summary = 'Module for IBAMobileBank. Conatins helpers that all modules can use'
  spec.license = { :type => 'MIT' }
  spec.authors = { 'Laszlo Teveli' => 'laszlo.teveli@incepteam.com' }
  spec.homepage = 'https://github.com/iba-dit/ibam-ios-app'
  spec.source = { :path => '.' }
  spec.source_files = 'Sources/**/*.swift'
  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.swift'
  end 
end
