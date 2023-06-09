# Идеальный вес. Программа запрашивает у 
# пользователя имя и рост и выводит идеальный
# вес по формуле (<рост> - 110) * 1.15, 
# после чего выводит результат пользователю на 
# экран с обращением по имени. Если идеальный 
# вес получается отрицательным, то выводится 
# строка "Ваш вес уже оптимальный"


puts "Расчет идеального веса.\n"
puts "Ваше имя?"
name = gets.chomp
puts "Ваш рост?"
height = gets.chomp
weight = (height.to_i - 110) * 1.15

if weight < 0
  puts "Ваш вес уже оптимальный!"
else
  puts "#{name}! Идеальный вес для Вашего роста - #{weight}."
end

