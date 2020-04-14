
Pod::Spec.new do |s|
  s.name             = 'PheumoniaDetector'
  s.version          = '1.0.0'
  s.summary          = 'A model to check disease -pheumonia.'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
Lightweight Library for scanning images for Pheumonia (Not Safe For Work) content.
                       DESC

  s.homepage         = 'https://github.com/MarcSteven/PheumoniaDetector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marc Steven' => 'marc.coders@gmail.com' }
  s.source           = { :git => 'https://github.com/MarcSteven/PheumoniaDetector.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.pod_target_xcconfig = { 'COREML_CODEGEN_LANGUAGE' => 'Swift' }

  s.source_files = 'PheumoniaDetector/Classes/**/*'
end
