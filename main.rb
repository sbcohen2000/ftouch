# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# main.rb
#
# This file defines the user interface for ftouch
require 'pathname'
require_relative 'Controllers/Parser'
require_relative 'Controllers/Errors'

CONFIG_PATH = './configs'

def main()
    filename = ARGV[0]
    config_file = nil

    error_handler = Errors.new()
    
    #get the configuration file
    if ARGV[1] == nil then #use default config
        config_file = Pathname.new(CONFIG_PATH + '/default.ft')
    else
        config_file = Pathname.new(ARGV[1])
    end

    if config_file and !config_file.exist?
        abort(config_file.to_s + ' does not exist')
    end

    config_file.open do |f|
        #create the configuration with the configuration file text
        parser = Parser.new(f.read, error_handler)
        parser.body
    end

end

#run main
main