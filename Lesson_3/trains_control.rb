# Управление поездами
#

class Station
  attr_reader :list_of_train

  def initialize(name)
    @name = name
    @list_of_train = []
  end

  def take_the_train=(train)
    self.list_of_train.append(train)
  end

  def get_trains_on_type(type)
    trains = []
    for train in list_of_train do
      if train.type == type then
        trains.append(train)
      end
    end
    trains
  end

  def send_train(train)
    train.forward
    self.list_of_train.delete(train)
  end
end


class Route
  attr_reader :start_station
  attr_reader :finish_station
  attr_accessor :current_index

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @list_station = []
    @current_index = 0
  end

  def add_station(station)
    self.list_station.append(station)
  end

  def del_station(station)
    self.list_station.delete(station)
  end

  def get_all_station
    puts("#{start_station} - #{list_station} - #{finish_station}")
  end

  def next_station
    self.current_index += 1
  end

  def prev_station
    self.current_index -= 1
  end

  def get_current_station
    list_station[current_index]
  end

  def get_next_station
    list_station[current_index + 1]
  end

  def get_prev_station
    list_station[current_index - 1]
  end
end


class Train
  attr_accessor :speed
  attr_accessor :num_train_car
  attr_accessor :type
  attr_reader :route

  def initialize(number, type, num_train_car)
    @number = number
    @type = type
    @num_train_car = num_train_car
    @speed = 0
    @route = 0
  end

  def stop
    self.speed = 0
  end

  def add_train_car
    if speed == 0 then
      self.num_train_car += 1
    end
  end

  def del_train_car
    if speed == 0 && num_train_car > 0 then
      self.num_train_car -= 1
    end
  end

  def route=(route)
    route.start_station
  end

  def forward
    route.next_station
  end

  def backward
    route.prev_station
  end

  def get_current_station
    route.get_current_station
  enid

  def get_next_station
    route.get_next_station
  end

  def get_prev_station
    route.get_prev_station
  end

  

end

