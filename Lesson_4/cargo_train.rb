# Грузовой поезд

require_relative 'train'

class CargoTrain < Train

  def add_wagon=(wagon)
    puts("Добавление вагона!")
    if not speed? and wagon.class == CargoWagon then
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить #{waggon.class} вагон! Поезд движется со скоростью #{@speed}, или вагон не грузовой!")
    end
  end

end
