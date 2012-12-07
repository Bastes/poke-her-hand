class Poker::Card
  include Comparable

  VALUE = /\A([2-9JQKA]|10)/
  VALUES = (2..10).
    inject({}) { |r, i| r.tap { r["#{i}"] = i } }.
    merge({ 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 })

  def initialize string
    @value = string[VALUE]
    @color = string[-1]
  end

  def to_s
    @value + @color
  end

  def <=> other
    -other.compare(self.value, @color)
  end

  def versus other
    -other.challenge(self.value)
  end

  def pred_value_to? other
    other.has_value? self.value.next
  end

  def same_color_as? other
    other.has_color? @color
  end

  protected

  def value
    VALUES[@value]
  end

  def has_value? value
    self.value == value
  end

  def has_color? color
    @color == color
  end

  def compare value, color
    [self.value, @color] <=> [value, color]
  end

  def challenge value
    self.value <=> value
  end
end
