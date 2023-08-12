module InstanceCounter
  def self.included(base)
    base.class_variable_set('@@instances_count', 0)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def  instances
      class_variable_get('@@instances_count')
    end
  end

  private
  module InstanceMethods
    def register_instance(instances_count)
      instances_count += 1
    end
  end
end
