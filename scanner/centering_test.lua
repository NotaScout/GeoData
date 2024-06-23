term.clear()

local function centerTextOnScreen(text, screenWidth, screenHeight)
    -- Calculate the starting positions to center text horizontally and vertically
    local textWidth = #text  -- Get the length of the text to be displayed
    local startX = math.floor((screenWidth - textWidth) / 2) + 1  -- Calculate starting x position
    local startY = math.floor(screenHeight / 2)  -- Calculate starting y position

    -- Print the text centered on the screen
    term.setCursorPos(startX, startY)
    print(text)
end

-- Example usage:
local screenWidth = 26  -- Example screen width
local screenHeight = 20  -- Example screen height
local text = "Centered Text Example"

centerTextOnScreen(text, screenWidth, screenHeight)