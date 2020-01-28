#!/usr/bin/env ruby
# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# main.rb
#
# This file defines the user interface for ftouch
require 'pathname'
require 'optparse'
require_relative 'Controllers/Parser'
require_relative 'Controllers/Errors'

CONFIG_PATH = './configs/'

def main()
    @options = {}

    #parse command line arguments, populating @options
    OptionParser.new do |opts|
        opts.on("-c", "--config=CONFIG_PATH", "Use a configuration from the filesystem") do |c_path|
            @options[:absolute_c_path] = c_path
        end

        opts.on("-l", "--local=CONFIG_PATH", "Use a configuration from the configs directory.") do |c_path|
            @options[:relative_c_path] = c_path
        end

        opts.on("-h", "--help", "Prints this help") do
            puts opts
            exit
        end
    end.parse!

    #outfile is whatever argument is left
    @options[:outfile] = ARGV[0]
    
    abort("No output file was supplied") if !@options[:outfile]

    if @options[:absolute_c_path] and @options[:relative_c_path] then
        abort("Cannot use -c and -l")
    end

    config_file = nil
    error_handler = Errors.new()
    
    #get the configuration file
    if !(@options[:absolute_c_path] or @options[:relative_c_path]) then
        config_file = Pathname.new(CONFIG_PATH + "default.ft")
    elsif @options[:absolute_c_path]
        config_file = Pathname.new(@options[:absolute_c_path])
    else
        config_file = Pathname.new(CONFIG_PATH + @options[:relative_c_path])
    end

    if config_file and !config_file.exist?
        abort(config_file.to_s + " does not exist")
    end

    config_file.open do |config|
        #create the configuration with the configuration file text
        parser = Parser.new(config.read, error_handler)
        output_text = parser.body
        File.open(@options[:outfile], "w") do |outfile|
            outfile.puts output_text
        end
    end

end

#run main
main