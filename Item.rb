require 'nil/symbol'

class Item
  attr_reader :description, :gold, :stats

  def initialize(description, gold, stats)
    @description = description
    @gold = gold
    if stats.class != Array
      stats = [stats]
    end
    @stats = stats
  end

  def getDescriptionForComparison
    if @description == "Doran's Blade"
      return "~~#{@description}"
    elsif @description == "Berserker's Greaves"
      return "~#{@description}"
    else
      return @description
    end
  end
end

class ItemStats
  include SymbolicAssignment

  Members = [
    :attackDamage,
    :attackSpeed,
    :criticalStrike,
    :criticalStrikeBonus,
    :flatArmorPenetration,
    :percentageArmorPenetration,
    :magicalDamage,
    :statikkShiv,
    :bladeOfTheRuinedKing,
    :malady,
  ]

  attr_reader *Members

  attr_reader :unique

  def initialize(statMap)
    Members.each do |symbol|
      setMember(symbol, 0)
    end
    @statikkShiv = false
    @bladeOfTheRuinedKing = false
    @malady = false
    statMap.each do |symbol, value|
      if !Members.include?(symbol)
        raise "Invalid symbol: #{symbol}"
      end
      setMember(symbol, value)
    end
    @unique = false
  end
end

class UniqueItemStats < ItemStats
  def initialize(statMap)
    super
    @unique = true
  end
end
