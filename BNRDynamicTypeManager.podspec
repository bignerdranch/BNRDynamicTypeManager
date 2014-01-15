Pod::Spec.new do |s|
  s.name         = "BNRDynamicTypeManager"
  s.version      = "0.1.0"
  s.summary      = "Library to help manage iOS 7's Dynamic Type"

  s.description  = <<-DESC
                   TODO: Write this description.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/bignerdranch/BNRDynamicTypeManager"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "John Gallagher" => "jgallagher@bignerdranch.com" }
  s.source       = { :git => "https://github.com/bignerdranch/BNRDynamicTypeManager.git", :tag => "0.1.0" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.subspec 'Core' do |core|
      core.source_files = 'BNRDynamicTypeManager/Core/*.{h,m}'
  end

  s.subspec 'Controls' do |controls|
      controls.dependency 'BNRDynamicTypeManager/Core'
      controls.source_files = 'BNRDynamicTypeManager/Controls/*.{h,m}'
  end
end
