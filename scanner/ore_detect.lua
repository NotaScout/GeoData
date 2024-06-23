geo = peripheral.wrap("back")

function getOreData(radius)
    
    sleep(1)
    local oredata
    oredata = geo.scan(radius)

    --local cooldown = geo.getScanCooldown()
    --print("Scan Cooldown",cooldown)
    if oredata then
        return oredata
    else
    end


end


-- searches table for relevant text
function searchTextInTable(tbl, searchText)
    for key, value in pairs(tbl) do
        if string.find(key, searchText, 1, true) then
            return {key = key, value = value}  -- Return the first match found
        end
    end
    
    return nil  -- Return nil if no match is found
end

-- reads the target keyword from target file (singular)
local function readSearchTarget()
    local file, err = fs.open("/scanner/ore_search_targets.txt", 'r')
    if not file then
        term.clear()
        error("File failed to open due to: " .. tostring(err))
    end

    local searchTarget = ""  -- string to store search target
    print("Target Found!\n")
    sleep(0.1)
    print("Reading Target ...\n")
    -- Read each line (one line) from the file and store in the table
    local searchTarget = file.readLine()  -- Read the first line
    local searchRadius = file.readLine() -- secondLine
    file.close()  -- Close the file after reading
term.clear()
term.setCursorPos(1,1)

    return searchTarget, searchRadius

end

local function searchOreData(data,targetTerm)

for key_1, value_1 in pairs(data) do
--print(value_1["name"])
if string.find(value_1["name"],targetTerm) then -- follows minecraft coord structure

--print("x",value_1["x"])
xcoord = value_1["x"]

--print("y",value_1["y"])
ycoord = value_1["y"]

--print("z",value_1["z"])
zcoord = value_1["z"]
return xcoord,ycoord,zcoord

-- then we return the closest one's XYZ then compare with the player's location
-- then give directions to the block
end
-- We want to index this table with index names, not index numbers
--print("\n")
 --for key_2, value_2 in pairs(value_1) do
 --print(key_2,value_2)
 --end
 --print("\n")
end
return nil,nil,nil
end


local function getHeadings(x, y, z)
    local headingNS = ""
    local headingEW = ""
    local headingUD = ""

    -- Determine North-South heading
    if z < 0 then
        headingNS = "North"  -- Negative z-axis (North)
    elseif z > 0 then
        headingNS = "South"  -- Positive z-axis (South)
    end

    -- Determine East-West heading
    if x < 0 then
        headingEW = "West"  -- Negative x-axis (West)
    elseif x > 0 then
        headingEW = "East"  -- Positive x-axis (East)
    end

    -- Determine Up-Down heading
    if y > 0 then
        headingUD = "Up"  -- Positive y-axis (Up)
    elseif y < 0 then
        headingUD = "Down"  -- Negative y-axis (Down)
    end

    return headingNS, headingEW, headingUD
end


-- start of program
-- waits for keypress to begin
--searchTerm = "wood"

searchRadius = 5
local target = ""
term.clear()
term.setCursorPos(1,1)
print("Press Any Key to Begin")
local event,startSearch = os.pullEvent("key")
term.clear()
term.setCursorPos(1,1)
-- we want to read in scan radius and scan target
print("Please Enter a Scan Target:\n")
local target = io.read()

term.clear()
term.setCursorPos(1,1)

if target == "" then
print("No Target Specified!\n")
sleep(2)
print("Locating Defaults ...\n")
sleep(0.56)
--opens the target file in read only mode (if the user has supplied no input)
target = readSearchTarget()
end

term.clear()
term.setCursorPos(1,1)


print("Please Enter a Scan Radius:\n")
local radius = io.read()

term.clear()
term.setCursorPos(1,1)


if radius == "" then


print("No Radius Specified!\n")
sleep(2)
print("Locating Defaults ...\n")
sleep(0.56)
--opens the target file in read only mode (if the user has supplied no input)
_,radius = readSearchTarget()
end




--&return contents in variable
print("Target:\n\n",target)
--keyword search through table to find matches





scan_result = getOreData(searchRadius) -- output data will be in table form. Each indice will contain:
 -- {"name",{table_of_tags},x,y,z}
-- tag table will (?) maybe find a use later, but will need to be subindexed


--[[ this one contains the table search

--print("Full data table:")
for key_1, value_1 in pairs(scan_result) do
print(value_1["name"])
if string.find(value_1["name"],"slab") then -- follows minecraft coord structure
print("x",value_1["x"])
print("y",value_1["y"])
print("z",value_1["z"])
-- then we return the closest one's XYZ then compare with the player's location
-- then give directions to the block
end
-- We want to index this table with index names, not index numbers
print(value_1[1])
print(value_1[2]) 
print(value_1[3])
print(value_1[4])
--print("\n")
 for key_2, value_2 in pairs(value_1) do
 --print(key_2,value_2)
 end
 --print("\n")
end
]]
--detected_target = searchTextInTable(scan_result,target)

--retrieve closest match x,y,z
local x_ore,y_ore,z_ore = searchOreData(scan_result,target)
if x_ore then
print(x_ore,y_ore,z_ore)
EW,UD,NS = getHeadings(x_ore,y_ore,z_ore)
print(EW,UD,NS)
--print(detected_target)

--get player x,y,z (playerPos = 0,0,0)

--take delta to get directions to match
else
print("No",target,"Found in Range")
end









