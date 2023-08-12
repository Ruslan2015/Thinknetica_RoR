require_relative 'manufacturer'

class Train
  @@trains = []

  def self.find(number)
    @@trains.each {|tr| tr if tr.number == number}
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
    if current_station_index > 0 then
      route.stations[self.current_station_index - 1]
    end
  end

  protected

  def speed?
    if speed == 0 then
      false
    else
      speed
    end
  end
end