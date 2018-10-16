return {
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
        print("count!")
        for _, _ in pairs(op) do
            count = count + 1
        end
        return count
    end
    --__metatable = 1
}