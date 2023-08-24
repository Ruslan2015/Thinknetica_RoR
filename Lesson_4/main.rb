require 'byebug'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'



class Main
  attr_accessor :stations
  attr_accessor :trains
  attr_accessor :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def test
    make_station('Москва')
    make_station('Питер')
    make_station('Тверь')
    make_station('Иркутск')
    make_station('Омск')

    make_train('101-00', 'cargo')
    make_train('102-aa', 'cargo')
    make_train('201-00', 'passenger')
    make_train('202-aa', 'passenger')

    make_route(stations[0], stations[1])
    make_route(stations[0], stations[3])

    puts 'Созданы станции:'
    Station.all.each {|st| puts "ID: #{st.object_id}, название: #{st.name}, к-во: #{st.class.instances}"}

    puts 'Созданы поезда:'
    Train.all.each {|tr| puts "Номер: #{tr.number}, тип: #{tr.class}, к-во: #{tr.class.instances}"}

    puts 'Созданы маршруты:'
    routes.each {|rt| puts "ID: #{rt.object_id}, между городами: #{rt.stations[0].name} -> #{rt.stations[1].name}"}

    puts 'Поиск поездов по номерам'
    puts 'Ищем номер 101'
    puts Train.find('101-00')
    puts 'Ищем номер 301'
    puts Train.find('301-00')
    puts 'и не находим его'

    puts 'Управление станциями'
    control_stations_of_route(routes[0], stations[2])
    control_stations_of_route(routes[1], stations[4])

    puts 'Назначение маршрутов поездам'
    set_route_to_train(routes[0], trains[0])
    puts "Поезд #{trains[0].object_id} на маршруте #{routes[0].object_id}"
    set_route_to_train(routes[1], trains[2])
    puts "Поезд #{trains[2].object_id} на маршруте #{routes[1].object_id}"

    puts 'Добавление вагонов к поездам'
    wagon1 = add_wagon_to_train(trains[0])
    puts "К #{trains[0].class} поезду #{trains[0].object_id} добавлен вагон #{wagon1.object_id} типа #{wagon1.class}"
    wagon2 = add_wagon_to_train(trains[2])
    puts "К #{trains[2].class} поезду #{trains[2].object_id} добавден вагон #{wagon2.object_id} типа #{wagon2.class}"

    puts 'Отцепление вагонов от поезда'
    del_wagon_from_train(trains[0])
    puts "От #{trains[0].class} поезда #{trains[0].object_id} отцеплен вагон"
    del_wagon_from_train(trains[2])
    puts "От #{trains[2].class} поезда #{trains[2].object_id} отцеплен вагон"

    puts 'Перемещение поезда'
    puts 'Добавление станции Тверь для тестирования'
    routes[0].add_station(stations[2], 0)
    puts "Поезд #{trains[0]} стоит на маршруте #{trains[0].route}"
    puts "Поезд находится на станции #{trains[0].current_station_index}: #{trains[0].route.stations[trains[0].current_station_index].name}"
    puts 'Движемся вперед'
    transfer_train(trains[0], 'f')
    puts "Поезд находится на станции #{trains[0].current_station_index}: #{trains[0].route.stations[trains[0].current_station_index].name}"
    puts 'Еще раз вперед'
    transfer_train(trains[0], 'f')
    puts "Поезд находится на станции #{trains[0].current_station_index}: #{trains[0].route.stations[trains[0].current_station_index].name}"
    puts 'Движемся назад'
    transfer_train(trains[0], 'b')
    puts "Поезд находится на станции #{trains[0].current_station_index}: #{trains[0].route.stations[trains[0].current_station_index].name}"
    puts 'Еще раз назад'
    transfer_train(trains[0], 'b')
    puts "Поезд находится на станции #{trains[0].current_station_index}: #{trains[0].route.stations[trains[0].current_station_index].name}"
    puts "Просмотр станций маршрута #{routes[0].object_id}"
    list_of_station(routes[0])
    puts "Просмотр поездов на станции #{stations[0].name}"
    list_of_train_at_station(stations[0])
  end

  def make_station(station_name)
    self.stations.append(Station.new(station_name))
  end

  def make_train(number, type_of_train)
    raise "Incorrect type! Pleas <cargo> or <passenger>" if type_of_train !~ /(^cargo$|^passenger$)/
    self.trains.append(CargoTrain.new(number)) if type_of_train == 'cargo'
    self.trains.append(PassengerTrain.new(number)) if type_of_train == 'passenger'
  end

  def make_route(start_station, end_station)
    self.routes.append(Route.new(start_station, end_station))
  end

  def control_stations_of_route(route, station)
    puts "Добавление станции #{station.name} в маршрут #{route.object_id}"
    routes.each { |rt| rt.add_station(station, 0) if rt == route }
    routes.each { |rt| rt.show_route if rt == route }
    puts "Удаление станции #{station.name} в маршрут #{route.object_id}"
    routes.each { |rt| rt.del_station(station) if rt == route }
    routes.each { |rt| rt.show_route if rt == route }
  end

  def set_route_to_train(route, train)
    train.set_route(route)
    route.stations[0].trains_at_the_station.append(train)
  end

  def add_wagon_to_train(train)
    if train.class == CargoTrain
      train.add_wagon(CargoWagon.new)
    elsif train.class == PassengerTrain
      train.add_wagon(PassengerWagon.new)
    end
  end

  def del_wagon_from_train(train)
    train.del_wagon
  end

  def transfer_train(train, vector)
    if vector == 'f'
      train.go_forward
    elsif vector == 'b'
      train.go_backward
    end
  end

  def list_of_station(route)
    route.stations.each { |st| puts "ID: #{st.object_id}, название: #{st[1].name}"}
  end

  def list_of_train_at_station(station)
    station.list_of_trains
  end

  def start()
    # Виртуальная железная дорога
    menu = {'A' => 'Создать станцию',
            'B' => 'Создать поезд',
            'C' => 'Создать маршрут',
            'D' => 'Управлять станциями маршрута',
            'F' => 'Назначить маршрут поезду',
            'G' => 'Добавить вагоны к поезду',
            'H' => 'Отцепить вагон от поезда',
            'I' => 'Переместить поезд по маршруту',
            'J' => 'Просмотреть список станций',
            'K' => 'Просмотреть список поездов на станции',
            'Q' => 'Завершить программу'}

    while 1 do
      puts '***************************'
      puts 'Виртуальная железная дорога'
      puts '***************************'
      menu.keys.each do |key|
        puts "#{key} - #{menu[key]}"
      end
      puts 'Выберете пункт меню...'
      chois = gets.chomp.upcase

      if chois == 'A' then
        puts 'Создание станции'

      elsif chois == 'B' then
        begin
        puts 'Создание поезда'
        number_of_train = gets.chomp
        type_of_train = gets.chomp
        make_train(number_of_train, type_of_train)
        rescue
          puts 'Неверные реквизиты поезда'
          retry
        end

      elsif chois == 'C' then
        puts 'Создание маршрута'

      elsif chois == 'D' then
        puts 'Управление станциями маршрута'

      elsif chois == 'F' then
        puts 'Назначение маршрута поезду'

      elsif chois == 'G' then
        puts 'Добавление вагонов к поезду'

      elsif chois == 'H' then
        puts 'Отцепление вагона от поезда'

      elsif chois == 'I' then
        puts 'Перемещение поезда по маршруту'

      elsif chois == 'J' then
        puts 'Просмотр списка станций'

      elsif chois == 'K' then
        puts 'Просмотр списка поездов на станции'

      elsif chois == 'Q' then
        puts 'Выход из программы'
        break

      else
        puts 'Не выбран пункт меню'
      end
    end
  end
end