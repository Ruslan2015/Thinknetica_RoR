# Класс маршрут
#

class Route
  attr_accessor :stations
  attr_accessor :number

  # Начальная и конечная станции указываются при создании маршрута
  def initialize(number, start_station, end_station)
    @number = number
    @stations = {0=>start_station, 1=>end_station} # Порядковый номер на маршруте => Название станции
  end

  # Добавить промежуточную станцию
  def add_station(station_name, station_before_key)
    # Для всех ключей больше чем station_before_key увеличить на единицу
    self.stations = stations.map { |st|
      st[0] += 1 if st[0] > station_before_key
      [st[0], st[1]]
    }
    # Добавить станцию с ключем station_before_key + 1
    self.stations.append([station_before_key+1, station_name])
    self.stations = Hash[self.stations]
  end

  # Удалить промежуточную станцию
  def del_station(id_of_station)
    self.stations.delete(id_of_station)
    # Для всех ключей больше чем id_of_station уменьшить ключ на единицу
    self.stations = stations.map { |st|
      st[0] -= 1 if st[0] >id_of_station
      [st[0], st[1]]
    }
    self.stations = Hash[self.stations]
  end

  # Вывести список всех станций по порядку от первой до последней
  def show_route
    self.stations.sort.each{ |st| puts "Номер: #{st[0]}, название: #{st[1]}"}
  end

end
