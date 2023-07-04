class Split
  def self.run(number)
    [number / 2, (number / 2.0).ceil]
  end
end
