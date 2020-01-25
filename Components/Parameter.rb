# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# Parameter.rb
#
# This file defines the Parameter class

class Parameter
    attr_reader :name
    def initialize(name, value)
        @name, @value = name, value
    end

    def value=(value)
        @value = value
    end

    def value()
        if @value.respond_to? :call then
            return @value.call
        end
        return @value
    end
end