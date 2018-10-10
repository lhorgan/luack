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
    __metatable = 1
}