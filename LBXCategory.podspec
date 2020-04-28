#
# Be sure to run `pod lib lint LBXCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LBXCategory'
  s.version          = '0.0.1'
  s.summary          = 'LBXCategory is Simple Category.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: LBXCategory is Simple Category, used all.
                       DESC

  s.homepage         = 'https://www.baidu.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '3257468284@qq.com' => 'libaoxi@yuelvhui.com' }
  s.source           = { :git => 'https://github.com/bestColor/LBXCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LBXCategory/0.0.1/**/*'
  
  # 第三方或自己创建的 .Framework的名称
  # s.vendored_frameworks = "YostarLib.framework"
  
  # 第三方或自己创建的 .a静态库的名称
  # s.vendored_libraries = "libYostarStaticLib.a"
  
  # 添加资源文件
  # s.resource = "XXX/XXXX/**/*.bundle"
  # s.resources = "XXX/XXXX/**/*.bundle"
  
  # CocoaPods会把这个库配置成static framework，同时支持Swift和Objective-C
  # s.static_framework = true
  
  # 是否使用ARC，如果指定具体文件，则具体的文件使用ARC
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'LBXCategory' => ['LBXCategory/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'QuartzCore', 'Accelerate', 'ImageIO'
  s.dependency 'SDWebImage'
end
