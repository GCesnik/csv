if Rails.env.test?

  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  # make sure uploader is auto-loaded
  CsvUploader

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
  CarrierWave.configure do |config|
    config.asset_host = ActionController::Base.asset_host
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     'AKIAJPHXIT4ZSDOEPJVQ',
        aws_secret_access_key: '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',
        region:                'us-east-1',
    }
    config.fog_directory  = 'csv-springbig-uploads'                                      # required
    config.fog_public     = true                                                 # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end



