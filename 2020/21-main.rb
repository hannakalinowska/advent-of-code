#! /usr/bin/env ruby

inputs = File.read('21-input.txt').split("\n")
#inputs = [
#'mxmxvkd kfcds sqjhc nhms (contains dairy, fish)',
#'trh fvjkl sbzzf mxmxvkd (contains dairy)',
#'sqjhc fvjkl (contains soy)',
#'sqjhc mxmxvkd sbzzf (contains fish)',
#]

allergens = {}
all_ingredients = []

inputs.each do |line|
  line =~ /^(.+) \(contains (.+)\)$/
  ingredients = $1.split(' ')
  all_ingredients << ingredients
  $2.split(", ").each do |allergen|
    allergens[allergen] ||= []
    allergens[allergen] << ingredients
  end
end

allergens = allergens.map {|a, i| i.reduce(&:&) }

bad_ingredients = []
loop do
  allergens.map! do |a|
    a = a - bad_ingredients
    if a.size == 1
      bad_ingredients += a
    end
    a
  end

  break if allergens.all? {|a| a.empty?}
end

puts (all_ingredients.flatten - bad_ingredients).size
