# Программа запрашивает основание и высоту треугольника
# и возвращает его площадь
#
puts "Расчет площади треугольника.\n"
puts "Длина основание треугольника?"
osnova = gets.chomp
puts "Длина высоты треугольника?"
visota = gets.chomp
area = osnova.to_f * visota.to_f * 0.5
puts "Площадь треугольника = #{area}."

