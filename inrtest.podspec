Pod::Spec.new do |s|
    s.name         = 'MX-Jason Chen'
    s.version      = '1.0.0'
    s.summary      = 'A test by Jason Chen'
    s.homepage     = 'https://github.com/chhsh122'
    s.license      = 'MIT'
    s.authors      = {'Jason Chen' => 'chhsh122@me.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/chhsh122/MS-Jason-Chen', :tag => s.version}
    s.source_files = 'inrtest/*.{h,m}'
    s.requires_arc = true
end
