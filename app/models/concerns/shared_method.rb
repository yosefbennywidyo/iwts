module SharedMethod
  extend ActiveSupport::Concern

  included do
    def generate_uniq_key(options={})
      if options[:selected] == 1
        return "#{Digest::MD5.hexdigest options[:email]}"
      elsif options[:selected] == 2
        return "#{Digest::MD5.hexdigest "wallet for #{options[:email]} created at #{Time.now}"}"
      elsif options[:selected] == 3
        return "#{Digest::MD5.hexdigest "#{Time.now}" + "#{rand}"}"
      end
    end
  end
end