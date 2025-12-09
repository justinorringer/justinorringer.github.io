# Load environment variables from .env file for local development
begin
  require 'dotenv'
  Dotenv.load('.env')
rescue LoadError
  # dotenv not available in production, use system environment variables
end

puts "=== LOADING ENVIRONMENT PLUGIN ==="

# Load environment variables using dotenv for local development
begin
  require 'dotenv'
  Dotenv.load('.env') if File.exist?('.env')
  puts "Loaded environment variables from .env file" if Jekyll.env == 'development'
rescue LoadError
  puts "Dotenv gem not available, using system environment variables" if Jekyll.env == 'development'
rescue => e
  puts "Error loading .env file: #{e.message}" if Jekyll.env == 'development'
end

Jekyll::Hooks.register :site, :after_init do |site|
  # Make all environment variables available as site.env
  site.config['env'] = ENV.to_h
  
  # Debug: Print important environment variables
  if Jekyll.env == 'development'
    puts "DEBUG: CLOUDINARY_CLOUD_NAME = #{ENV['CLOUDINARY_CLOUD_NAME']}"
    puts "DEBUG: JEKYLL_ENV = #{Jekyll.env}"
  end
  
  # Automatically populate Cloudinary config from environment variables
  if site.config['cloudinary']
    # Set API credentials if available
    site.config['cloudinary']['api_key'] = ENV['CLOUDINARY_API_KEY'] if ENV['CLOUDINARY_API_KEY']
    site.config['cloudinary']['api_secret'] = ENV['CLOUDINARY_API_SECRET'] if ENV['CLOUDINARY_API_SECRET']
    
    # Override cloud_name and base_url from environment if set
    if ENV['CLOUDINARY_CLOUD_NAME']
      site.config['cloudinary']['cloud_name'] = ENV['CLOUDINARY_CLOUD_NAME']
      site.config['cloudinary']['base_url'] = "https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}/image/upload"
      puts "DEBUG: Set base_url to #{site.config['cloudinary']['base_url']}" if Jekyll.env == 'development'
    else
      puts "DEBUG: CLOUDINARY_CLOUD_NAME environment variable not found" if Jekyll.env == 'development'
    end
  else
    puts "DEBUG: No cloudinary config found in site.config" if Jekyll.env == 'development'
  end
end

# Liquid filter to access environment variables directly in templates
module Jekyll
  module EnvironmentFilter
    def env(input)
      ENV[input]
    end
  end
end

Liquid::Template.register_filter(Jekyll::EnvironmentFilter)

# Liquid filter to access environment variables directly in templates
module Jekyll
  module EnvironmentFilter
    def env(input)
      ENV[input]
    end
  end
end

Liquid::Template.register_filter(Jekyll::EnvironmentFilter)
