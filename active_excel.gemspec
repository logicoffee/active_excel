
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_excel/version"

Gem::Specification.new do |spec|
  spec.name          = "active_excel"
  spec.version       = ActiveExcel::VERSION
  spec.authors       = ["logicoffee"]
  spec.email         = ["riemann1618@gmail.com"]

  spec.summary       = %q{Build ActiveRecord objects from an Excel file with vaidations}
  spec.description   = %q{This is a gem which allows you to build ActiveRecord objects from an Excel file with validations in your rails application.}
  spec.homepage      = "https://github.com/logicoffee/active_excel"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 5.2.2"
  spec.add_dependency "rubyXL", "~> 3.3.33"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "sqlite3", "~> 1.3.13"
end
