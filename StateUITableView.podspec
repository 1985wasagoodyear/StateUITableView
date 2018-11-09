Pod::Spec.new do |s|  
    s.name              = 'StateUITableView'
    s.version           = '1.0.0'
    s.summary           = 'A UITableView driven by enumerations to present different states for loading, error, empty, and loaded states.'
    s.homepage          = 'https://github.com/1985wasagoodyear/StateUITableView'

    s.author            = { 'Name' => 'https://github.com/1985wasagoodyear' }
    s.license           = { :type => 'MIT License', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => "https://github.com/1985wasagoodyear/StateUITableView.git", :tag => "1.0.0" }
          
    s.source_files     = "StateUITableView", "StateUITableView/**/*.{h,m,swift}"

end  