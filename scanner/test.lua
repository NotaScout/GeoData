geo = peripheral.wrap("back")





local result, error_message = geo.scan(1)

if result then
    -- 'result' is a table, iterate over its entries
    for i, entry in ipairs(result) do
        -- 'entry' represents each subtable in 'result'
        print("Entry " .. i .. ":")
        for key, value in pairs(entry) do
            print(key, value)
        end
    end
else
    -- 'result' is nil, print the error message
    print("Scan failed:", error_message)
end