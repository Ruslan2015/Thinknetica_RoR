# Управление поездами


class Station
  # Станция
  # - Название указываетсяс при создании
  # - Может принимать поезда (по одному за раз)
  # - Может возвращать список всех поездов на станции, находящихся в текущий момент
  # - Может возвращать список поездов на станции по типу: к-во грузовых, пассажирских
  # - Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции)

  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @name = name
    
    # Список поездов на станции
    # Содержит экземпляры класса Train
    @trains = []
  end

  def take_the_train=(train)
    # Принять поезд
    # Аргумент - экземпляр класса Train
    trains.append(train)
  end

  def get_trains_on_type(type)
    # Вернуть список поездов на станции по титпу
    trains.select{|train| train.type == type}
  end

  def send_train(train)
    # Отправить поезд
    # Аргумент - экземпляр класса Train
    train.forward # Поезд перемещается на следующую станция (метод объекта Train)
    trains.delete(train)
  end
end


class Route
  # Маршрут
  # - Начальная и конечная станции указываются при создании маршрута
  # - Может добавлять промежуточную станцию в список
  # - Может удалять промежуточную станцию из списка
  # - Может выводить список всех станций по-порядку от начальной до конечной
   
  attr_reader :stations
  attr_accessor :current_station

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    @current_station = 0
  end

  def add_station(station)
    # Вставить новую станцию перед конечной станцией 
    stations.insert(stations.size-1, station)
  end

  def del_station(station)
    # Удалить из маршрута станцию с именем station
    stations.delete(station)
  end

  def get_stations
    # Вывести список всех станций
    puts(stations)
  end
end


class Train
  # Поезд
  # - Номер (стр), тип (грузовой, пассажирский), количество вагонов указываются при создании экземпляра
  # - Может набирать скорость
  # - Может возвращать текущую скорость
  # - Может тормозить (сбрасывать скорость до нуля)
  # - Может возвращать количество вагонов
  # - Может прицеплять/отцеплять вагоны (по одному вагону за операцию), только если поезд не движется.
  # - Может принимать маршрут следования (объект класса Route)
  # - При назначении маршрута поезду, поезд автоматически перемещается на первую станцию в маршруте.
  # - Может перемещаться на одну станцию вперед или назад
  # - Может возвращать предыдущую станцию, текущую, следующую, на основе маршрута

  attr_accessor :speed # Набрать скорость, вернуть текущую скорость 
  attr_accessor :number_of_wagons # Вернуть количество вагонов
  attr_accessor :type
  attr_reader :route
  attr_accessor :current_station_index

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def stop
    # Тормозить
    self.speed = 0
  end

  def add_wagon
    # Прицепить вагон
    if speed == 0 then
      self.number_of_wagons += 1
    end
  end

  def del_wagon
    # Отцепить вагон
    if speed == 0 && number_of_wagons > 0 then
      self.num_train_car -= 1
    end
  end

  def route=(route)
    # Назначить маршрут и встать на первую станцию
    self.route = route
    self.current_station_index = 0
  end

  def go_forward
    # Переместиться на одну станцию вперед
    self.current_station_index += 1 if next_station    
  end

  def go_backward
    # Переместиться на одну станцию назад
    self.curret_station_index -= 1 if previous_station    
  end

  def current_station
    # Вернуть текущую станцию 
    route[@current_station_index]
  end

  def next_station
    # Вернуть следующую станцию
    if current_station_index < (route.stations.size -1) then # Если станция не последняя
      route[@current_station_index + 1]
    end
  end

  def previous_station
    # Вернуть предыдущую станцию
    if current_station_index > 0 then # Если станция не первая
      route[@current_station_index - 1]
    end
  end

  

end

