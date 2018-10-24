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
    tables_arr_rev = {},
    tables_lens = {},
    tables_arr_ind = {},
    tables_arr_len = {},
    --__metatable = 1
}


t.__len = function(tbl)
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
        t.tables_arr_len[tbl] = 1
        t.tables_arr_rev[tbl] = {}
        --t.tables_arr_ind[tbl] = {stack={1}, len=1}
        rawset(t.tables_arr_ind, tbl, {})
        rawset(t.tables_arr_ind[tbl], "stack", {1})
        rawset(t.tables_arr_ind[tbl], "len", 1)
        t.tables_lens[tbl] = 0
    end

    if value == nil then
        if rawget(t.tables[tbl], key) ~= nil then
            print("removing key " .. tostring(key))
            rawset(t.tables_lens, tbl, rawget(t.tables_lens, tbl) - 1)
            rawset(rawget(t.tables, tbl), key, nil)

            table_arr_ind = rawget(rawget(t.tables_arr_rev, tbl), key)
            
            rawset(rawget(t.tables_arr, tbl), table_arr_ind, nil)
            rawset(rawget(t.tables_arr_rev, tbl), key, nil)

            stack_len = rawget(rawget(t.tables_arr_ind, tbl), "len")
            rawset(rawget(t.tables_arr_ind, tbl), "len", stack_len + 1)
            rawset(rawget(rawget(t.tables_arr_ind, tbl), "stack"), stack_len + 1, table_arr_ind)
        end
    else
        if rawget(t.tables[tbl], key) == nil then
            print("new key " .. tostring(key))
            rawset(t.tables_lens, tbl, rawget(t.tables_lens, tbl) + 1)
            
            print("LENGTH " .. tostring(rawget(rawget(t.tables_arr_ind, tbl), "len")))
            --pull empty index off the top of the stack
            stack_len = rawget(rawget(t.tables_arr_ind, tbl), "len")
            index_val = rawget(rawget(rawget(t.tables_arr_ind, tbl), "stack"), stack_len)

            rawset(rawget(t.tables_arr, tbl), index_val, key)
            rawset(rawget(t.tables_arr_rev, tbl), key, index_val)

            rawset(rawget(rawget(t.tables_arr_ind, tbl), "stack"), stack_len, nil)
            rawset(rawget(t.tables_arr_ind, tbl), "len", stack_len - 1)
            
            tables_arr_size = rawget(t.tables_arr_len, tbl)
            if index_val > tables_arr_size then
                tables_arr_size = tables_arr_size + 1
                rawset(t.tables_arr_len, tbl, tables_arr_size)
            end

            if stack_len - 1 == 0 then
                rawset(t.tables_arr_ind[tbl], "stack", {tables_arr_size + 1})
                rawset(t.tables_arr_ind[tbl], "len", 1)
            end
        end
    end

    rawset(t.tables[tbl], key, value)
end


t.__pairs = function(tbl)
    i = 0
    len = #tbl
    num_found = 0
    local function iter()
        while num_found < len do
            i = i + 1
            print("i is " .. i)
            local key = rawget(rawget(t.tables_arr, tbl), i)
            print("le key: " .. tostring(key))
            v = rawget(rawget(t.tables, tbl), key)
            if v then
                num_found = num_found + 1
                return key, v
            else
                print("nothing found at " .. tostring(i))
            end
        end
    end

    return iter
end


t.__ipairs = function(tbl)
    i = 0
    len = #tbl
    num_found = 0
    nonint_found = true
    local function iter()
        while num_found < len and nonint_found do
            i = i + 1
            print("i is " .. i)
            local key = rawget(rawget(t.tables_arr, tbl), i)
            print("le key: " .. tostring(key))
            v = rawget(rawget(t.tables, tbl), key)
            if not ((type(key) == "number" and math.floor(key) == key) and (type(v) == "number" and math.floor(v) == v)) then
                nonint_found = false
            end
            if v and nonint_found then
                num_found = num_found + 1
                return key, v
            else
                print("nothing found at " .. tostring(i))
            end
        end
    end

    return iter
end


return t