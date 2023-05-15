Pod::Spec.new do |spec|

  spec.name         = "TFY_PageSegmentKit"

  spec.version      = "2.2.8"

  spec.summary      = "全能分段选择器"

  spec.description  = <<-DESC 
  全能分段选择器 
  DESC

  spec.homepage     = "https://github.com/13662049573/TFY_PageSegmentController"

  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }

  spec.platform     = :ios,"12.0" 

  spec.source       = {:git => "https://github.com/13662049573/TFY_PageSegmentController.git",:tag => spec.version }

  spec.source_files  =  "TFY_PageSegmentController/TFY_PageSegmentKit/TFY_PageSegmentKit.h"
  
  spec.subspec 'CsutomScroller' do |ss|
    ss.dependency "TFY_PageSegmentKit/Param"
    ss.source_files  = "TFY_PageSegmentController/TFY_PageSegmentKit/CsutomScroller/**/*.{h,m}"
  end

  spec.subspec 'Param' do |ss|
    ss.source_files  = "TFY_PageSegmentController/TFY_PageSegmentKit/Param/**/*.{h,m}"
  end

  spec.frameworks    = "Foundation","UIKit"

  spec.requires_arc = true

end

