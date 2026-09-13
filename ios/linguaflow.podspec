Pod::Spec.new do |spec|
  spec.name             = 'linguaflow'
  spec.version          = '0.1.0'
  spec.summary          = 'Native App Attest adapter for the LinguaFlow Flutter SDK.'
  spec.homepage         = 'https://github.com/ensarkurrt/linguaflow'
  spec.license          = { :type => 'MIT' }
  spec.author           = { 'LinguaFlow' => 'support@linguaflow.dev' }
  spec.source           = { :path => '.' }
  spec.source_files     = 'linguaflow/Sources/linguaflow/**/*.swift'
  spec.resource_bundles = {
    'linguaflow_privacy' => ['linguaflow/Sources/linguaflow/PrivacyInfo.xcprivacy']
  }
  spec.dependency 'Flutter'
  spec.platform         = :ios, '13.0'
  spec.swift_version    = '5.9'
end
