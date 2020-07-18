
# require_relative './EXAMPLE_class'


class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def initialize(locations)
    @locations = locations

  end
