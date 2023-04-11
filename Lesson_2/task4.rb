# bukva
#
h = {}
gl_arr = ['a', 'e', 'i', 'o', 'u']
k = 0

for sym in ('a'..'z') do
  
  if gl_arr.include? sym then
    h[sym] = k
  end
  k += 1
end

puts h


