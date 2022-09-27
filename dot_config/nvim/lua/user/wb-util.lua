-- Simple pretty printer, global for debugging
if pp == nil then
  print(pp)
  function pp(t, n)
    if n == nil then
      n = 'table'
    end

    print(n)
    for k, v in pairs(t) do
      print(' ', k, v)
    end
    print('/' .. n)
  end
else
  print('pp was already defined')
end
