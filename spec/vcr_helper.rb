# frozen_string_literal: true

require('vcr')

VCR.configure do |c|
  c.default_cassette_options = { record: :new_episodes, record_on_error: false }
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :faraday
  c.configure_rspec_metadata!
end
