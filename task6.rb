# tovar
#
#
puts "Сумма покупок\n"

list = {}
summ = 0

while 1 do
  puts "Название товара?"
  name = gets.chomp
  if name == "стоп" then
    break
  end
  puts "Цена товара?"
  cost = gets.to_f
  puts "Количество товара?"
  num = gets.to_f
  list[name] = {cost: cost, num: num}
  summ += num * cost
end

for k, d in list do
  puts "Товара #{k} ценой #{d[:cost]} на сумму #{d[:num]}."
end
puts "Общая стоимость товаров = #{summ}!"

