# Класс поезд


class Train

  attr_accessor :speed # Набирает скорость, возвращает скорость
  attr_accessor :wagons # Возвращает массив объектов "вагон"
  attr_accessor :route
  attr_accessor :current_station_index
  attr_reader :number

  # При создании присваивается номер
  def initialize(number)
    @number = number
  end

  # Тормозит (сбрасывает скорость до 0)
  def stop
    self.speed = 0
  end

  # Может прицеплять и отцеплять вагоны если не движется
  def add_wagon=(wagon)
    puts("Добавление вагона!")
    if not speed? then
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить вагон! Поезд движется со скоростью #{@speed}")
    end
  end

  def del_wagon(wagon_id)
    self.wagons.delete(wagon_id) if not speed? and self.wagons.size
  end

  # Принимает маршрут следования и в этот момент перемещается на первую станцию
  def route=(route)
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
    if current_station_index < (route.stations.size - 1) then
      route[@current_station_index + 1]
    end
  end

  def previous_station
    if current_station_index > 0 then
      route[@current_station_index - 1]
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
  #
end

