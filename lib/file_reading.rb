class FileReading

  def self.read_file
    File.open("./users.txt", "r") do |file|
      puts file.read().include? "Grace"

    # file_data = file.readlines.map(&:chomp)  
    # file.close
    end
  end
end