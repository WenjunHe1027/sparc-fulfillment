VCR.configure do |config|

  config.cassette_library_dir = 'vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.default_cassette_options = { allow_playback_repeats: true }
end

RSpec.configure do |config|

  config.after(:each) do
    VCR.eject_cassette
  end

  config.before(:each, type: :request) do

    VCR.configure do |config|
      config.ignore_localhost = false
    end
  end

  config.after(:each, type: :request) do

    VCR.configure do |config|
      config.ignore_localhost = true
    end
  end

  config.before(:each, type: :job) do

    VCR.configure do |config|
      config.ignore_localhost = false
    end
  end

  config.after(:each, type: :job) do

    VCR.configure do |config|
      config.ignore_localhost = true
    end
  end
end
