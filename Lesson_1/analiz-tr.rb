# Программа анализа треугольника
#
puts "Анализ треугольника.\n"

puts "Задайте длину первой стороны:"
side_1 = gets.chomp.to_f
puts "Задайте длину второй стороны:"
side_2 = gets.chomp.to_f
puts "Задайте длину третьей стороны:"
side_3 = gets.chomp.to_f

sides = [side_1, side_2, side_3]

s_sides = sides.sort.reverse

if s_sides[0] > (s_sides[1] + s_sides[2]) then
  puts "Такого треугольника не существует!"
else
  if side_1 == side_2 && side_2 == side_3 then
    puts "Треугольник равнобедренный и равносторонний!"
    s = true
  elsif side_1 == side_2 || side_1 == side_3 || side_2 == side_3 then
    puts "Треугольник равнобедренный!"
    s = true
  end


  if s_sides[0]**2 == (s_sides[1]**2 + s_sides[2]**2) then
    puts "Треугольник прямоугольный!"
    s = true
  end

  if !s then
    puts "Треугольник не имеет отличительных признаков!"
  end
end


