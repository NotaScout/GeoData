geo = peripheral.wrap("back")

local function centerTextOnScreen(text, screenWidth, screenHeight)
    -- Calculate the starting positions to center text horizontally and vertically
    local textWidth = #text  -- Get the length of the text to be displayed
    local startX = math.floor((screenWidth - textWidth) / 2) + 1  -- Calculate starting x position
    local startY = math.floor(screenHeight / 2)  -- Calculate starting y position

    -- Print the text centered on the screen
    term.setCursorPos(startX, startY)
    print(text)
end

-- adjustable height centering
local function centerTextOnWidthScreen(text, screenWidth,cursorY)
    -- Calculate the starting positions to center text horizontally and vertically
    local textWidth = #text  -- Get the length of the text to be displayed
    local startX = math.floor((screenWidth - textWidth) / 2) + 1  -- Calculate starting x position
    --local startY = math.floor(screenHeight / 2)  -- Calculate starting y position

    -- Print the text centered on the screen
    term.setCursorPos(startX, cursorY)
    print(text)
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

    -- Read each line from the file
    local searchTarget = file.readLine()  -- Read the first line
    local searchRadius = file.readLine()  -- Read the second line

    file.close()  -- Close the file after reading

    term.clear()
    term.setCursorPos(1, 1)

    return searchTarget, searchRadius
end

local function writeSearchTarget(searchTarget)
    local file, err = fs.open("/scanner/ore_search_targets.txt", 'w')
    if not file then
        term.clear()
        error("File failed to open due to: " .. tostring(err))
    end
    file.writeLine(searchTarget)  -- Write searchTarget to the first line
    --file.writeLine(searchRadius)  -- Write searchRadius to the second line

    file.close()  -- Close the file after writing

    term.clear()
    term.setCursorPos(1, 1)
end

local function writeSearchRadius(searchRadius)
    local file, err = fs.open("/scanner/ore_search_targets.txt", 'r')
    if not file then
        term.clear()
        error("File failed to open due to: " .. tostring(err))
    end
	
    local searchTarget = file.readLine()  -- Read the first line
    file.close()


    local file, err = fs.open("/scanner/ore_search_targets.txt", 'w')
    if not file then
        term.clear()
        error("File failed to open due to: " .. tostring(err))
    end

    file.writeLine(searchTarget)  -- Write searchTarget to the first line
    file.writeLine(searchRadius)  -- Write searchRadius to the second line

    file.close()  -- Close the file after writing

    term.clear()
    term.setCursorPos(1, 1)
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


centerTextOnScreen("Press Any Key to Begin",26,20)
--print("Press Any Key to Begin")
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
else 
writeSearchTarget(target)
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
else
writeSearchRadius(radius)
end




--&return contents in variable
centerTextOnWidthScreen("Target",26,2)
centerTextOnWidthScreen(target,26,4)
centerTextOnWidthScreen("==<---->==",26,5)


local noTargetFound = "No " .. target .. " Found in Range"

--keyword search through table to find matches


local function mainLoop()

local running = true  -- Flag to control the loop

    while running do
        local scan_result = getOreData(searchRadius)

        if scan_result then
            -- Process the scan_result
            local x_ore, y_ore, z_ore = searchOreData(scan_result, target)

            if x_ore then
                local NS, EW, UD = getHeadings(x_ore, y_ore, z_ore)
		term.setCursorPos(1,10)
		term.clearLine()
                -- Clear screen before printing new results
                term.setCursorPos(1, 1)

                -- Print results
                -- row 1
                local colLeft1 = twoColumnCenter(26, string.len(UD), 1)
                term.setCursorPos(colLeft1, 7)
                term.clearLine()
		if y_ore ~= 0 then
                print(UD)
                local colRight1 = twoColumnCenter(26, string.len(math.abs(y_ore)), 0)
                term.setCursorPos(colRight1, 7)
                print(math.abs(y_ore))
		end

                -- row 2
                local colLeft2 = twoColumnCenter(26, string.len(EW), 1)
                term.setCursorPos(colLeft2, 9)
                term.clearLine()
		if x_ore ~= 0 then
                print(EW)
                local colRight2 = twoColumnCenter(26, string.len(math.abs(x_ore)), 0)
                term.setCursorPos(colRight2, 9)
                print(math.abs(x_ore))
		end
                -- row 3
                local colLeft3 = twoColumnCenter(26, string.len(NS), 1)
                term.setCursorPos(colLeft3, 11)
                term.clearLine()
		if z_ore ~= 0 then
                print(NS)
                local colRight3 = twoColumnCenter(26, string.len(math.abs(z_ore)), 0)
                term.setCursorPos(colRight3, 11)
                print(math.abs(z_ore))
		end

                -- Add option for break if you only want to scan once after finding the result
                -- break
            else
		term.clear()
		centerTextOnWidthScreen("Target",26,2)
		centerTextOnWidthScreen(target,26,4)
		centerTextOnWidthScreen("==<---->==",26,5)
                centerTextOnScreen("No matching target found.", 26, 20)
            end
        else
            -- Optional delay or other handling if scan_result is nil
            os.sleep(1)  -- Sleep for 1 second before retrying
        end
    end
end


mainLoop()
