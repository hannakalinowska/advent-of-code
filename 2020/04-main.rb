#! /usr/bin/env ruby

inputs = File.read('04-input.txt').split("\n\n").map{ |line| line.gsub("\n", " ") }


class Passport
  def initialize(line)
    @stuff = {}

    line.split.each do |token|
      key, value = token.split(':')
      @stuff[key] = value
    end
  end

  def valid?
    valid_byr? &&
      valid_iyr? &&
      valid_eyr? &&
      valid_hgt? &&
      valid_hcl? &&
      valid_ecl? &&
      valid_pid?
  end

  def valid_byr?
    valid_number_in_range?(@stuff['byr'], (1920 .. 2002))
  end

  def valid_iyr?
    valid_number_in_range?(@stuff['iyr'], (2010 .. 2020))
  end

  def valid_eyr?
    valid_number_in_range?(@stuff['eyr'], (2020 .. 2030))
  end

  def valid_hgt?
    return false unless @stuff['hgt']

    @stuff['hgt'] =~ /^(\d+)(\w+)$/
    number = $1
    unit = $2

    valid = false

    case unit
    when 'in'
      valid_number_in_range?(number, (59 .. 76))
    when 'cm'
      valid_number_in_range?(number, (150 .. 193))
    end

    valid
  end

  def valid_hcl?
    @stuff['hcl'] && (@stuff['hcl'] =~ /^#[0-9a-f]{6}$/)
  end

  def valid_ecl?
    @stuff['ecl'] && %w(amb blu brn gry grn hzl oth).include?(@stuff['ecl'])
  end

  def valid_pid?
    @stuff['pid'] && (@stuff['pid'] =~ /^\d{9}$/)
  end

  private

  def valid_number_in_range?(number, range)
    number && range.include?(number.to_i)
  end
end

valid = inputs.count do |line|
  passport = Passport.new(line)
  passport.valid?
end

puts valid
