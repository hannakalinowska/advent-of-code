module SpringsChecker
  class << self
    def valid?(line, check)
      groups = line.split(/\.+/).reject(&:empty?)
      select = true
      groups = groups.select {|g| select = false if g =~ /\?/; select}
      lengths = groups.map(&:length)
      check = check.split(',').map(&:to_i)

      #require 'pry-byebug'; binding.pry
      if line =~ /\?/
        #puts "#{line} #{check}" if rand(100_000) == 0
        return true if groups.empty?
        return false if (groups.map(&:length) - check).any?
        return false if groups.length > check.length
        return false if groups.map(&:length) != check[0 .. groups.length-1]

        return true
      else
        lengths == check
      end
    end
  end
end
