class Explode
  def self.run(number)
    puts number
    # This is probably better done with nested arrays
    number.sub(/^((\[(\d,)?){4,})\[(\d),(\d)\]+?(\d)?/) do
      require 'pry'; binding.pry
      puts
    end
  end
end
