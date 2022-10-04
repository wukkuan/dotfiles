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

-- Naively joins two tables. Assumes a table is either an array or a map, not
-- both.
if wb__table_join == nil then
  function wb__table_join(a, b)
    local retval = {}
    if #a == 0 then
      for k, v in pairs(a) do
        retval[k] = v
      end
      for k, v in pairs(b) do
        retval[k] = v
      end
    else
      for i, v in ipairs(a) do
        table.insert(retval, v)
      end
      for i, v in ipairs(b) do
        table.insert(retval, v)
      end
    end
    return retval
  end
else
  print('wb__table_join was already defined')
end
