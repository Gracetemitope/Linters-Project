class Player
  attr_accessor :name, :symbol, :options
       
  def initialize(name = '', symbol = '', options = [])
    @name = name
      @symbol = symbol
    @options = options
  end  

  puts "Hello World"

