require_relative 'train'
require_relative 'instance_counter'

class CargoTrain < Train
  include InstanceCounter
  def initialize(name)
    super
    @@instances_count = register_instance(@@instances_count)
  end

  def add_wagon(wagon)
    if not speed? and wagon.class == CargoWagon
      self.wagons[wagon.object_id] = wagon
    else
      puts("Нельзя прицепить #{wagon.class} вагон! Поезд движется со скоростью #{@speed}, или вагон не грузовой!")
    end
  end
end
