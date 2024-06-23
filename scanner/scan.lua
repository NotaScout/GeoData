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
message = "Press Any Key to Begin"
cursorStart = 25-math.ceil(string.len(message))
term.setCursorPos(cursorStart,8)
print(message)
local event,startSearch = os.pullEvent("key")
term.clear()
term.setCursorPos(1,1)
--opens the target file in read only mode

print("Initializing ... \n")
sleep(.1)
--file = io.open("/scanner/search_targets.txt","w")
--file:write("coal")
--file:close()


-- IMPORTANT
-- searchTargets !=
-- searchTerm
print("Locating Ore Targets ...\n")
sleep(.1)
-- Open the file in read mode

local function readSearchTargets()
    local file, err = fs.open("/scanner/search_targets.txt", 'r')
    if not file then
        term.clear()
        error("File failed to open due to: " .. tostring(err))
    end

    local searchTargets = {}  -- Table to store search targets
    print("Ore Targets Found!\n")
    sleep(0.1)
    print("Reading Ore Targets ...\n")
    sleep(0.2)
    -- Read each line from the file and store in the table
    local line = file.readLine()  -- Read the first line
    while line do
        table.insert(searchTargets, line)  -- Insert the line into the table
        line = file.readLine()  -- Read the next line
    end

    file.close()  -- Close the file after reading

    return searchTargets

end

local function twoColumnCenter(length,objectLength,column)
    middle = math.ceil(length/2)
    objectMiddle = math.ceil(string.len(objectLength)/2)
    
    if column == 1 then --left
    centeredVal = math.ceil(middle/2)-objectMiddle
    else
    centeredVal = middle+math.ceil(middle/2)-objectMiddle
    end
    return centeredVal
end


local searchTargets = readSearchTargets() -- pulls the terms out of our function

--calculate positions of elements

monitorWidth = 25 -- from what I looked up, this is 51 chars

topLeftTableHeader = "Found:"

topRightTableHeader = "Amount:"

H_middle = math.ceil(monitorWidth/2)

topLeftHeaderPos = math.ceil(H_middle/2)-math.ceil(string.len(topLeftTableHeader)/2)

sleep(1)

term.clear()

--print(topLeftHeaderPos)

term.setCursorPos(topLeftHeaderPos,1)

print(topLeftTableHeader)

topRightHeaderPos = H_middle+math.ceil(H_middle/2)-math.ceil(string.len(topRightTableHeader)/2)

term.setCursorPos(topRightHeaderPos,1)

--

print(topRightTableHeader)





while true do

    data = getChunkdata()
    --print("Searching for:")
-- start index loop
    for index, target in ipairs(searchTargets) do
-- index is i
        --print(target)
    local searchTerm = target


    
    if data then
    
    
    local matches = searchTextInTable(data, searchTerm)
    local netOre = 0
    
    -- Output the matches where the search term was found
    --print("Matches for '" .. searchTerm .. "' in the table:")
    for _, match in ipairs(matches) do
        netOre = netOre + match.value
    end
    if netOre > 0 then
        center_L = twoColumnCenter(25,searchTerm,1)
        term.setCursorPos(center_L,index+1) -- using top row for labels
        term.clearLine()
        print(searchTerm)
        center_R = twoColumnCenter(25,netOre,0)
        term.setCursorPos(center_R,index+1)
        print(netOre)
    end
    end
    end -- end index loop
end
