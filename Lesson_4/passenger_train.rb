# Пассажирский поезд

require_relative 'train'

class PassengerTrain < Train

  def add_wagon=(wagon)
    puts("Добавление вагона!")
    if not speed? and wagon.class == PassengerWagon then
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить #{waggon.class} вагон! Поезд движется со скоростью #{@speed}, или вагон не пассажирский!")
    end
  end

end
