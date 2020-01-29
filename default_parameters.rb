# Written by Samuel Burns Cohen
# Jan 25, 2019
# 
# default_parameters.rb
#
# This file defines the implementations of some parameters that are included
# by default

# parameter info
#   > each parameter lambda function must take no arguments
#   > each default parameter should return some contextual information that
#     can be retrived by calling its name. For example, the author of the 
#     document, or today's date.

DEFAULT_PARAMETERS = [
    Parameter.new('filename', -> {
        return ARGV[0]
    }),
    Parameter.new('logname', -> {
        return ENV["LOGNAME"] ? ENV["LOGNAME"] : ""
    }),
    Parameter.new('date', -> {
        t = Time.new
        return "#{t.month}/#{t.day}/#{t.year}"
    }),
    Parameter.new('day', -> {
        return Time.new.day
    }),
    Parameter.new('month', -> {
        return Time.new.month
    }),
    Parameter.new('year', -> {
        return Time.new.year
    }),
    Parameter.new('time', -> {
        t = Time.new
        return "#{t.hour}:#{t.min}"
    }),
    Parameter.new('hour', -> {
        return Time.new.hour
    }),
    Parameter.new('min', -> {
        return Time.new.min
    }),
    Parameter.new('sec', -> {
        return Time.new.sec
    }),
    Parameter.new('null', -> {
        return ""
    })
]