# !/usr/bin/env ruby

require_relative '../lib/linters'
require_relative '../lib/file_reading'

@file_path = 'test.rb'
check = Linters.new(@file_path)
check.check_double_quotes
check.check_trailing_white_spaces
check.check_indentation_error
check.check_end__of_block_error
check.check_empty_line_error

if check.errors.empty? && check.checker.error.empty?
  puts '...........................'.colorize(:yellow)
  puts 'No offenses detected'.colorize(:green)
  puts '...........................'.colorize(:yellow)
else
  check.errors.each do |err|
    puts "#{err.colorize(:red)} in #{check.checker.file_path.colorize(:yellow)}"
  end
end
