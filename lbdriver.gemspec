$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lbdriver/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lbdriver"
  s.version     = LBDriver::VERSION
  s.authors     = ["Michael Mealling"]
  s.email       = ["mmealling@pipefish.com"]
  s.homepage    = "http://pipefish.com/lbdriver"
  s.summary     = "A non-blocking IO layer to the LogicBlox protobuf interface"
  s.description = "Uses protobuf and celluloid to provide a standard IO layer for LogicBlox databases in much the same vein as old school JDBC/ODBC drivers."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.require_path = 'lib'

  s.add_dependency "rails", "~> 4.0.0.rc2"
  s.add_dependency "celluloid-io"
  s.add_dependency "protobuf", "~>2.8.8"
  s.add_dependency "bindata", "~>1.8.0"
  s.add_dependency "connection_pool", "~>1.2.0"

end
