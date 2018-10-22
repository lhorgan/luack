t = {
    __eq = function(lhs, rhs)
        for key, val in pairs(lhs) do
            if rhs[key] == nil then
                return false
            end
        end

        for key, val in pairs(rhs) do
            if lhs[key] == nil then
                return false
            end
        end

        for key, val in pairs(lhs) do
            if lhs[key] ~= rhs[key] then
                return false
            end
        end
        return true
    end,
    tables = {},
    tables_arr = {},
    tables_lens = {},
    __metatable = 1
}


t.__len = function(tbl)
    --[[count = 0

    if t.tables[tbl] == nil then
        t.tables[tbl] = {}
    end
    
    for _, _ in pairs(t.tables[tbl]) do
        count = count + 1
    end
    return count--]]

    curr_len = rawget(t.tables_lens, tbl)
    if curr_len == nil then
        rawset(t.tables_lens, tbl, 0)
        curr_len = 0
    end
    return curr_len
end


--Winner Takes All
t.__index = function(tbl, key, value)
    return rawget(t.tables[tbl], key)
end


t.__newindex = function(tbl, key, value)
    print("n: " .. tostring(tbl) .. " " .. tostring(key) .. " " .. tostring(value))
    if t.tables[tbl] == nil then
        t.tables[tbl] = {}
        t.tables_arr[tbl] = {}
        t.tables_lens[tbl] = 0
    end

    if value == nil then
        if rawget(t.tables[tbl], key) ~= nil then
            print("removing key " .. tostring(key))
            rawset(t.tables_lens, tbl, rawget(t.tables_lens, tbl) - 1)
        end
    else
        if rawget(t.tables[tbl], key) == nil then
            print("new key " .. tostring(key))
            rawset(t.tables_lens, tbl, rawget(t.tables_lens, tbl) + 1)
            rawset(rawget(t.tables_arr, tbl), rawget(t.tables_lens, tbl), key)
        end
    end

    rawset(t.tables[tbl], key, value)
end


t.__pairs = function(tbl)
    -- Iterator function
    local function stateless_iter(tbl, k, i)
        i = i + 1
        print("grr " .. tostring(i))
        print(t.tables_arr[tbl])
        local key = rawget(rawget(t.tables_arr, tbl), i)
        print("le key ..." .. tostring(key))
        v = rawget(rawget(t.tables, tbl), key)
        if v then return key, v end
    end
  
    -- return iterator function, table, and starting point
    return stateless_iter, tbl, nil, 0
end


return t