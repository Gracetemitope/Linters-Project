require 'colorize'
require 'strscan'
require_relative '../lib/file_reading'

class Linters
  attr_reader :checker, :errors

  def initialize(file_path)
    @checker = ReadFile.new(file_path)
    @errors = []
    @keywords = %w[begin case class def do if module unless]
  end

  # Errors to Check:

  # check double_quotes
  def check_double_quotes
    @checker.lines.each_with_index do |line, index|
      next unless line.include? '"'

      @errors << "line:#{index + 1}:#{line.size - 1}:
      Error: Prefer single-quoted strings when you don\'t need string
      interpolation or special symbols"
    end
  end

  # check_trailing_white_spaces
  def check_trailing_white_spaces
    @checker.lines.each_with_index do |line, index|
      if line[-2] == ' ' && !line.strip.empty?
        @errors << "line:#{index + 1}:#{line.size - 1}: Error: Trailing whitespaces detected."
        + " '#{line.gsub(/\s*$/, '_')}'"
      end
    end
  end

  # check_end_of_block_error
  def check_end__of_block_error
    keyw_count = 0
    end_count = 0
    @checker.lines.each_with_index do |line, _index|
      keyw_count += 1 if @keywords.include?(line.split(' ').first) || line.split(' ').include?('do')
      end_count += 1 if line.strip == 'end'
    end

    status = keyw_count <=> end_count
    error_def("Lint/Syntax: Missing 'end'") if status.eql?(1)
    error_def("Lint/Syntax: Unexpected 'end'") if status.eql?(-1)
  end

  # empty lines def
  def check_empty_line_error
    @checker.lines.each_with_index do |line, index|
      check_class_empty_line_error(line, index)
      check_def_empty_line_error(line, index)
      check_end_empty_line_error(line, index)
      check_do_empty_line_error(line, index)
    end
  end

  # check_identation_error
  # rubocop: disable Metrics/CyclomaticComplexity
  def check_indentation_error
    msg = 'Inconsistent Identation: Use 2 spaces for indentation.'
    current_val = 0
    indent_val = 0
    @checker.lines.each_with_index do |line, index|
      strip_line = line.strip.split(' ')
      exp_val = current_val * 2
      res_word = %w[class def if elsif until module unless begin case]

      next unless !line.strip.empty? || !strip_line.first.eql?('#')

      indent_val += 1 if res_word.include?(strip_line.first) || strip_line.include?('do')
      indent_val -= 1 if line.strip == 'end'

      next if line.strip.empty?

      indent_error(line, index, exp_val, msg)
      current_val = indent_val
    end
  end
  # rubocop: enable Metrics/CyclomaticComplexity

  private

  # rubocop: disable Metrics/CyclomaticComplexity

  def indent_error(line, index, exp_val, msg)
    strip_line = line.strip.split(' ')
    emp = line.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)
    if line.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      error_def("line:#{index + 1} #{msg}") unless end_chk
    elsif !emp[0].size.eql?(exp_val)
      error_def("line:#{index + 1} #{msg}")
    end
  end
  # rubocop: enable Metrics/CyclomaticComplexity

  # empty_line def
  def check_class_empty_line_error(line, index)
    msg = 'Extra empty line detected at class body beginning'
    return unless line.strip.split(' ').first.eql?('class')

    error_def("line:#{index + 2} #{msg}") if @checker.lines[index + 1].strip.empty?
  end

  # def empty line
  def check_def_empty_line_error(line, index)
    msg1 = 'Extra empty line detected at method body beginning'
    msg2 = 'Use empty lines between method definition'

    return unless line.strip.split(' ').first.eql?('def')

    error_def("line:#{index + 2} #{msg1}") if @checker.lines[index + 1].strip.empty?
    error_def("line:#{index + 1} #{msg2}") if @checker.lines[index - 1].strip.split(' ').first.eql?('end')
  end

  # def empty_line_error

  def check_end_empty_line_error(line, index)
    return unless line.strip.split(' ').first.eql?('end')

    error_def("line:#{index} Extra empty line detected at block body end") if @checker.lines[index - 1].strip.empty?
  end

  def check_do_empty_line_error(line, index)
    msg = 'Extra empty line detected at block body beginning'
    return unless line.strip.split(' ').include?('do')

    error_def("line:#{index + 2} #{msg}") if @checker.lines[index + 1].strip.empty?
  end

  # passing in error def
  def error_def(error_msg)
    @errors << error_msg
  end
end
