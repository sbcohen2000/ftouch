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
    
    #as opposed to value(), raw_value does not execute the lambda at @value
    #if it exists.
    def raw_value()
        return @value
    end

    def apply_class(func, arguments)
        if func.respond_to? :call then
            return @value = func.call(self, arguments)
        end
        return @value
    end
end