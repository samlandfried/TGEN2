# frozen_string_literal: true

require('vcr')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :faraday
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
  c.debug_logger = $stderr
end
