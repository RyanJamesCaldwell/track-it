# frozen_string_literal: true

# awesome print
begin
  require 'awesome_print'

  if defined?(Pry)
    AwesomePrint.pry!
  else
    AwesomePrint.irb!
  end
rescue LoadError => err
  warn "Couldn't load awesome_print: #{err}"
end

# configure irb
IRB.conf[:PROMPT_MODE] = :SIMPLE

# irb history
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File::expand_path('.irbhistory')

# load .irbrc_rails in rails environments
railsrc_path = File.expand_path('.irbrc_rails')
if (ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
  rescue StandardError
    warn "Could not load: '#{railsrc_path}' because of #{$!.message}"
  end
end

class Object
  def interesting_methods
    case self.class
    when Class
      public_methods.sort - ActiveRecord::Base.public_methods
    when Module
      public_methods.sort - Module.public_methods
    else
      public_methods.sort - Object.new.public_methods
    end
  end
end

