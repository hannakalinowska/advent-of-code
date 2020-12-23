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

allergens = allergens.map {|a, i| [a, i.reduce(&:&)] }.to_h

bad_ingredients = {}
loop do
  allergens = allergens.map { |k, a|
    a = a - bad_ingredients.values.flatten
    if a.size == 1
      bad_ingredients[k] ||= []
      bad_ingredients[k] += a
    end
    [k, a]
  }.to_h

  break if allergens.values.all? {|a| a.empty?}
end

puts bad_ingredients.sort.map{|k, v| v}.join(',')
