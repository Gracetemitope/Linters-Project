require_relative '../lib/linters'

describe Linters do
  let(:checker) { Linters.new('test.rb') }
  describe '#check_double_quotes' do
    it 'check double quotes error' do
      checker.check_double_quotes
      expect(checker.errors[0]).to eql('line:10:20: Error: Prefer single-quoted strings when you don\'t need string interpolation or special symbols')
    end

    it 'check double quotes error in a wrong line' do
      checker.check_double_quotes
      expect(checker.errors[0]).to_not eql('line:10:25: Error: Prefer single-quoted strings when you don\'t need string interpolation or special symbols')
    end
  end
  describe '#check_trailing_white_spaces' do
    it 'check trailing white spaces' do
      checker.check_trailing_white_spaces
      expect(checker.errors[0]).to eql('line:8:7: Error: Trailing whitespaces detected.')
    end
    it 'do not check trailing white spaces' do
      checker.check_trailing_white_spaces
      expect(checker.errors[0]).to_not eql('line:18:7: Error: Trailing whitespaces detected.')
    end
  end
  describe '#check_indentation_error' do
    it 'check indentation error' do
      checker.check_indentation_error
      expect(checker.errors[0]).to eql('line:6 Inconsistent Identation: Use 2 spaces for indentation.')
    end
    it 'do not check indentation error on the right now' do
      checker.check_indentation_error
      expect(checker.errors[0]).to_not eql('line:7 Inconsistent Identation: Use 2 spaces for indentation.')
    end
  end
  describe '#check_end_of_block_error' do
    it 'check end of block error' do
      checker.check_end__of_block_error
      expect(checker.errors[0]).to eql("Lint/Syntax: Expect token 'end'")
    end
    it 'do not check end of block error' do
      checker.check_end__of_block_error
      expect(checker.errors[0]).to_not eql('Lint/Syntax: Not missing end')
    end
  end
  describe '#check_empty_line_error' do
    it 'check empty line error' do
      checker.check_empty_line_error
      expect(checker.errors[0]).to_not eql('Lint/Syntax: Not missing end')
    end
  end
end
