module Observer
  attr_reader :observers

  def initialize options 
    @observers = []
  end

  def add(observer)
    @observers << observer
  end

  def notify
    @observers.each{ |observer| observer.acknowledge } 
  end
end
