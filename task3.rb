# fibinachi
#
val_prev = 0
val_next = 1
val_summ = val_prev + val_next

arr = [val_prev, val_next]

while val_summ < 100 do
  arr.append(val_summ)
  val_prev = val_next
  val_next = val_summ
  val_summ = val_prev + val_next
end

puts arr

