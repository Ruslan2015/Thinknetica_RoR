require_relative 'train'

class PassengerTrain < Train
  def add_wagon(wagon)
    if not speed? and wagon.class == PassengerWagon
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить #{wagon.class} вагон! Поезд движется со скоростью #{@speed}, или вагон не пассажирский!")
    end
  end
end