# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xplenty/api/version"

Gem::Specification.new do |s|
  s.name        = "xplenty-api"
  s.version     = Xplenty::API::VERSION
  s.authors     = ["xmpolaris (Chen ZhongXue)", "motymichaely (Moty Michaely)"]
  s.email       = ["xmpolaris@gmail.com", "moty.mi@gmail.com"]
  s.homepage    = "http://github.com/xplenty/xplenty.rb"
  s.summary     = %q{Ruby Client for the Xplenty API}
  s.description = %q{Ruby Client for the Xplenty API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'excon', '~>0.20.0'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end
