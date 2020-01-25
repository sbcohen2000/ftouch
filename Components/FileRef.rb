# Written by Samuel Burns Cohen
# Jan 25, 2019
# 
# FileRef.rb
#
# This file defines a FileRef

class FileRef 
    attr_accessor :file, :line, :col
    def initialize(file, line, col)
        @file, @line, @col = file, line, col
    end

    def to_s()
        "#{@file} #{@line}:#{@col}"
    end
end