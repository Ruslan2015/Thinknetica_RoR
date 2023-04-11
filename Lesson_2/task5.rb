# number date

puts "Число месяца от 1 до 31?: "
day = gets.to_i
puts "Месяц от 1 до 12?: "
month = gets.to_i
puts "Год: "
year = gets.to_i

visok = false

if year % 4 == 0 then
  if year % 100 == 0 then
    if year % 400 == 0 then
      visok = true
    end
  else
    visok = true
  end
end

if visok then
  fday = 29
  sday = "високосный"
else
  fday = 28
  sday = "не високосный"
end

puts "#{day}.#{month}.#{year} - #{sday}"

myear = {1 => 31,
        2 => fday,
        3 => 31,
        4 => 30,
        5 => 31,
        6 => 30,
        7 => 31,
        8 => 31,
        9 => 30,
        10 => 31,
        11 => 30,
        12 => 31}

days = 0

for m, d in myear do
  puts "#{m}-#{d}"
  if month == m then
    days += day
  elsif month > m then
    days += d
  end
end

puts "Всего прошло #{days} дней!"













