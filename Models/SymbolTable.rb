# Written by Samuel Burns Cohen
# Jan 24, 2019
# 
# SymbolTable.rb
#
# This file defines the SymbolTable class

require_relative '../Components/Parameter' 

class SymbolTable
public
    def initialize()
        @parameters = Array.new
        add_defaults()
    end

    def add_parameter(parameter_name, value = nil)
        @parameters << Parameter.new(parameter_name, value)
    end

    def set_value(parameter_name, value)
        find_parameter(parameter_name).value = value
    end

    def get_value(parameter_name)
        find_parameter(parameter_name).value
    end
private
    def add_defaults()
        @parameters << Parameter.new('filename', -> {
            return 'yolo.txt'
        })
    end

    def find_parameter(parameter_name)
        @parameters.each do |p|
            return p if p.name == parameter_name
        end
        puts "Parameter #{param.name} was not found"
        return nil
    end

end