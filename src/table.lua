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
    __len = function(op)
        count = 0
        for _, _ in pairs(op) do
            count = count + 1
        end
        return count
    end,
    __index = function(t, k)
        print(ind)
    end,
    inserting = false,
    --__metatable = 1
}

t.__newindex = function(table, k, v)
    print(t)
    rawset(t, k, v)
    rawset(table, k, v)
end

return t