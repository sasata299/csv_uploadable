# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_uploadable/version"

Gem::Specification.new do |s|
  s.name        = "csv_uploadable"
  s.version     = CsvUploadable::VERSION
  s.authors     = ["sasata299"]
  s.email       = ["sasata299@livedoor.com"]
  s.homepage    = ""
  s.summary     = %q{this is a library for csv upload}
  s.description = %q{this is a library for csv upload}

  s.rubyforge_project = "csv_uploadable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
