-- wrap our peripheral in something easier to type
geo = peripheral.wrap("back")-- in my case I have a geo scanner

function getChunkdata()
    
    sleep(1)
    local chunkdata
    chunkdata = geo.chunkAnalyze()
    
    if chunkdata then
        --term.clear()
        --term.setCursorPos(1,1)
        -- print("Coal:" .. chunkdata["minecraft:coal_ore"])  -- test
        return chunkdata
    else
        end


end





-- Function to search for specified text in a table with string keys
function searchTextInTable(tbl, searchText)
    local results = {}-- Table to store matches
    
    for key, value in pairs(tbl) do
        if string.find(key, searchText, 1, true) then
            table.insert(results, {key = key, value = value})-- Store key and corresponding value
        end
    end
    
    return results
end
--[[
-- Example usage:
local data = {}
data = getChunkdata()
local searchTerm = "coal"
local matches = searchTextInTable(data, searchTerm)

-- Output the matches where the search term was found
print("Matches for '" .. searchTerm .. "' in the table:")
for _, match in ipairs(matches) do
print("Key:", match.key, "Value:", match.value)
end

]]

-- start of program
-- waits for keypress to begin
term.clear()
term.setCursorPos(1,1)
print("Press Any Key to Begin")
local event,startSearch = os.pullEvent("key")
term.clear()
term.setCursorPos(1,1)
--opens the target file in read only mode

print("Initializing ... ")
--sleep(.1)
--file = io.open("/scanner/search_targets.txt","w")
--file:write("coal")
--file:close()


-- IMPORTANT: CHANGE
-- searchTargets
-- to searchTerm
print("Finding Search Targets ...")
--sleep(.1)
local file, err = fs.open("/scanner/search_targets.txt", 'r')
if file then -- check to ensure the file opened
  local searchTargets = file.readAll()
  print("Searching for:\n" .. searchTargets)
  file.close() -- always close the file after reading
    -- do stuff with the data
else
  -- the file failed to open, tell the user
  term.clear()
  error("File failed to open due to: " .. tostring(err))
end


while true do

    
    data = getChunkdata()
    if data then
    
    local searchTerm = "diamond"
    local matches = searchTextInTable(data, searchTerm)
    local netOre = 0
    
    -- Output the matches where the search term was found
    --print("Matches for '" .. searchTerm .. "' in the table:")
    for _, match in ipairs(matches) do
        netOre = netOre + match.value
    end
    if netOre > 0 then
        term.setCursorPos(1,1)
        term.clear()
        print("Found:", searchTerm, "Amount:", netOre)    
    end
    end
end
