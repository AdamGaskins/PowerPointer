require File.expand_path("../lib/powerpointer/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "powerpointer"
  s.version     = PowerPointer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Gaskins"]
  s.email       = ["adam@theadamgaskins.com"]
  s.homepage    = "https://github.com/AtmoEntity/PowerPointer"
  s.summary     = "PowerPointer is an easy to use ruby library allowing you to create .pptx files from scratch."
  s.description = "PowerPointer is an easy to use ruby library allowing you to create .pptx files from scratch."

  s.required_rubygems_version = ">= 1.3.6"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end