
Pod::Spec.new do |s|
  s.name         = "UIView+hiddenLayout"
  s.version      = "0.0.2"
  s.summary      = " UIView+hiddenLayout 当控件需要hidden 时自动更新约束."
  s.description  = <<-DESC
                当view 需要显示或者隐藏时可以自动调整view 的约束或着还原约束，而不需要手动再去更改某个约束，前提是使用autolayout布局。
                   DESC
  s.homepage     = "https://github.com/ShelockWindy/MyiOSDemo"
  s.license      = "MIT "
  s.author             = { "washeng" => "2517185883@qq.com" }
  
  s.platform     = :ios, "7.0"
 
  s.source       = { :git => "https://github.com/ShelockWindy/MyiOSDemo.git", :tag => s.version }


  # ――― Source Code ――――――――――――――――――――――――――――――――――――――――――
  s.source_files  =  "ShareDemo/UIView+hiddenLayout/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
   # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
