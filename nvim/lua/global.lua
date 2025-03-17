function PrintTable(tbl, indent)
  indent = indent or 0
  for key, value in pairs(tbl) do
    local formatting = string.rep(" ", indent) .. key .. ": "
    if type(value) == "table" then
      print(formatting)
      PrintTable(value, indent + 2)
    else
      print(formatting .. tostring(value))
    end
  end
end

function Len(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
