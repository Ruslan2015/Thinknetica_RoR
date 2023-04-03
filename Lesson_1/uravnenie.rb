# Решение квадратного уравнения
#

puts "Решение квадратного уравнения"

puts "Задайте коэффициент A"
a = gets.chomp.to_f
puts "Задайте коэффициент B"
b = gets.chomp.to_f
puts "Задайте коэффициент C"
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d < 0 then
  puts "Корней нет!"
elsif d == 0 then
  x1 = -b/2*a
  puts "Дескриминант: #{d}, корень: #{x1}"
else
  x1 = (-b + Math.sqrt(d)) / 2 * a
  x2 = (-b - Math.sqrt(d)) / 2 * a
  puts "Дескриминант: #{d}, корень 1: #{x1}, корень 2: #{x2}"
end


