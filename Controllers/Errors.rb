# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# Errors.rb
#
# This file defines the Errors class

require_relative '../Components/Token.rb'

class Errors
public

    attr_reader :num_errors
    def initialize()
        @fatal = false
        @num_errors = 0
    end

    def put(value, fatal = true)
        @fatal = fatal or @fatal
        @num_errors += 1
        text = value.is_a?(Token) ? value.content : value

        if value.is_a? Token then
            puts "Syntax Error @ #{value.location.to_s + ": " + text}"
        else
            puts "Identifer Error: #{text}"
        end

        exit(1) if fatal?
    end

    def fatal?
        @fatal
    end
end