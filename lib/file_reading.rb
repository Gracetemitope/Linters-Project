class ReadFile
  attr_reader :lines, :file_path, :lines_count, :error

  def initialize(file_path)
    @error = ''
    @file_path = file_path
    file = File.open(@file_path, 'r')
    return unless file

    @lines = File.readlines(@file_path)
    @lines_count = @lines.length
  end
end
