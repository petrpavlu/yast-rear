ENV["Y2DIR"] = File.expand_path("../../src", __FILE__)

require "yast"
require "yast/rspec"

# stable testing in localized env
ENV["LC_ALL"] = "en_US.UTF-8"

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    # make sure we mock only the existing methods
    mocks.verify_partial_doubles = true
  end
end

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end

  src_location = File.expand_path("../src", __dir__)
  # track all ruby files under src
  SimpleCov.track_files("#{src_location}/**/*.rb")

  # use coveralls for on-line code coverage reporting at Travis CI
  if ENV["TRAVIS"]
    require "coveralls"

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  end
end
