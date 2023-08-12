require_relative 'instance_counter'

class Station
  include InstanceCounter
  @@stations = []

  def self.all
    @@stations
  end

  attr_accessor :trains_at_the_station
  attr_accessor :name

  # При создании указывается название
  def initialize(name)
    @name = name
    @trains_at_the_station = []
    @@stations << self
    @@instances_count = register_instance(@@instances_count)
  end


  # Принять поезд по одному за раз
  def take_the_train=(train)
    self.trains_at_the_station[train.object_id] = train
  end

  # Вернуть список поездов на станции, находящихся в текущий момент
  def list_of_trains
    if trains_at_the_station
      trains_at_the_station.each { |tr| puts "#{tr.object_id}"}
    end
  end

  # Вернуть список поездов на станции по типу (к-во пассажирских, грузовых)
  def list_of_trains_at_type
    num_cargo = 0
    num_passg = 0
    trains_at_the_station.values.each { |tr|
      num_cargo += 1 if tr.class == CargoTrain
      num_passg += 1 if tr.class == PassengerTrain
    }
    puts "Пассажирских поездов #{num_passg}, грузовых поездов #{num_cargo}"
  end

  # Отправить поезд по одному за раз
  def send_the_train=(id_of_train)
    # Удалить из списка соответствующий объект
    trains_at_the_station.delete(id_of_train)
  end
end