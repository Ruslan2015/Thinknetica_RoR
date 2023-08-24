require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  #include InstanceCounter
  @@trains = []

  NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  def self.all
    @@trains
  end

  def self.find(number)
    res = nil
    @@trains.each {|tr| res=tr if tr.number == number}
    res
  end

  include Manufacturer

  attr_accessor :speed # Набирает скорость, возвращает скорость
  attr_accessor :wagons # Возвращает массив объектов "вагон"
  attr_accessor :route
  attr_accessor :current_station_index
  attr_accessor :number

  def initialize(number)
    @@trains << self
    @number = number
    @wagons  = {}
    @route = nil
    @current_station_index = nil
    #@@instances_count = register_instance(@@instances_count)
    validate!
  end

  # Тормозит (сбрасывает скорость до 0)
  def stop
    self.speed = 0
  end

  # Может прицеплять и отцеплять вагоны если не движется
  def add_wagon(wagon)
    if not speed?
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить вагон! Поезд движется со скоростью #{@speed}")
    end
  end

  def del_wagon
    self.wagons.delete(wagons.size - 1) if not speed? and self.wagons.size
  end

  # Принимает маршрут следования и в этот момент перемещается на первую станцию
  def set_route(route)
    self.route = route
    self.current_station_index =  0
  end

  # Перемещается вперед и назад по одной станции за раз
  def go_forward
    self.current_station_index += 1 if next_station
  end

  def go_backward
    self.current_station_index -= 1 if previous_station
  end

  # Возвращает текущую, предыдущую и следующую станции на основе маршрута
  def current_station
    route[@current_station_index]
  end

  def next_station
    if current_station_index < (route.stations.size - 1)
      route.stations[self.current_station_index + 1]
    end
  end

  def previous_station
    if current_station_index > 0
      route.stations[self.current_station_index - 1]
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Number can't be nill" if number.nil?
    raise "Invalid format of number" if number !~ NUMBER_FORMAT
  end

  def speed?
    if speed == 0
      false
    else
      speed
    end
  end
end