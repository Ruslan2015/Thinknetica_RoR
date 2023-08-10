require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

stations = []
trains = []
routes = []


# Виртуальная железная дорога
menu = {"A" => "Создать станцию",
        "B" => "Создать поезд",
        "C" => "Создать маршрут",
        "D" => "Управлять станциями маршрута",
        "F" => "Назначить маршрут поезду",
        "G" => "Добавить вагоны к поезду",
        "H" => "Отцепить вагон от поезда",
        "I" => "Переместить поезд по маршруту",
        "J" => "Просмотреть список станций",
        "K" => "Просмотреть список поездов на станции",
        "Q" => "Завершить программу"}

while 1 do
  puts "***************************"
  puts "Виртуальная железная дорога"
  puts "***************************"
  menu.keys.each do |key|
    puts "#{key} - #{menu[key]}"
  end
  puts "Выберете пункт меню..."
  chois = gets.chomp.upcase

  if chois == "A" then
    puts "Создание станции"
    puts "Укажите название станции"
    station_name = gets.chomp
    stations.append(Station.new(station_name))

  elsif chois == "B" then
    puts "Создание поезда"
    puts "Укажите номер поезда"
    number_of_train = gets.chomp
    puts "Укажите тип поезда: 1 - грузовой, 2 - пассажирский"
    type_of_train = gets.chomp
    trains.append(CargoTrain(number_of_train)) if type_of_train == 1
    trains.append(PassengerTrain(number_of_train)) if type_of_train == 2

  elsif chois == "C" then
    puts "Создание маршрута"
    puts "Укажите номер маршрута"
    number_of_route = gets.chomp
    puts "Укажите имя начальной станции из ранее созданных"
    start_station = gets.chomp
    puts "Укажите имя конечной станции из ранее созданных"
    end_station = gets.chomp
    routes.append(Route(number_of_route, start_station, end_station))

  elsif chois == "D" then
    puts "Управление станциями маршрута"
    puts "Укажите номер маршрута, в который вы хотите добавить станцию"
    current_route = gets.chomp
    puts "Виберете: 1 - добавить станцию, 2 - просмотреть список станций, 3 - удалить станцию"
    select_st = gets.chomp
    if select_st == 1
      # добавление
      puts "Укажите имя новой станции"
      new_station_name = gets.chomp
      puts "Укажите номер станции, после которой вы хотите добавить станцию"
      station_before_key = gets.chomp
      routes.each { |rt| rt.add_station(new_station_name, station_before_key if rt.number == carrent_route) }
    elsif select_st == 2
      # просмотр списка
      routes.each { |rt| rt.show_route if rt.number == carrent_route }
    elsif select_st = 3
      # удалить станцию
      puts "Укажите ID станции"
      station_id = gets.chomp
      routes.each { |rt| rt.del_station(station_id) if rt.number == carrent_route }

  elsif chois == "F" then
    puts "Назначение маршрута поезду"
    puts "Укажите номер поезда"
    number_of_train = gets.chomp
    puts "Укажите номер маршрута"
    number_of_route = gets.chomp
    trains.each { |tr| tr.route=routes.each {|rt| rt if rt.number == number_of_route}}

  elsif chois == "G" then
    puts "Добавление вагонов к поезду"
    puts "Укажите номер поезда"
    number_of_train = gets.chomp
    trains.each { |tr|
      if tr.class == CargoTrain and tr.number == number_of_train
        tr.add_wagon(CargoWagon.new)
      end
      if tr.class == PassengerTrain and tr.number == number_of_train
        tr.add_wagon(PassengerWagon.new)
      end
    }

  elsif chois == "H" then
    puts "Отцепление вагона от поезда"
    puts "Укажите номер поезда"
    number_of_train = gets.chomp
    # Выводим список вагонов
    trains.each { |tr|
      if tr.number = number_of_train
        tr.wagons
      end
      puts "Укажите ID вагона"
      wagon_id = gets.chomp
      tr.del_wagon(wagon_id)
    }

  elsif chois == "I" then
    puts "Перемещение поезда по маршруту"
    puts "Укажите номер поезда"
    number_of_train = gets.chomp
    puts "Выберете направление: 1 - вперед, 2 - назад"
    vector = gets.chomp
    trains.each { |tr|
      if tr.number = number_of_train
        tr.go_forward if vector == 1
        tr.go_backward if vector == 2
      end
    }

  elsif chois == "J" then
    puts "Просмотр списка станций"
    stations.each { |st| puts "ID: #{st.object_id}, название: #{st.name}"}

  elsif chois == "K" then
    puts "Просмотр списка поездов на станции"
    # Выводим список станций
    stations.each { |st| puts st.object_id}
    puts "Укажите станцию, на которой хотите просмотреть поезда"
    station_id = gets.chomp
    stations.each { |st| st.list_of_trains if st.object_id == station_id}

  elsif chois == "Q" then
    puts "Выход из программы"
    break

  else
    puts "Не выбран пункт меню"
  end
end
