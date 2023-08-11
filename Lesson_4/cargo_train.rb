require_relative 'train'

class CargoTrain < Train
  def add_wagon(wagon)
    if not speed? and wagon.class == CargoWagon
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить #{wagon.class} вагон! Поезд движется со скоростью #{@speed}, или вагон не грузовой!")
    end
  end
end
