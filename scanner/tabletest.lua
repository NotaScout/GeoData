
term.clear()

local function generateCenteredTable(screenWidth, screenHeight)
    -- Define table dimensions
    local tableWidth = 2
    local tableHeight = 3

    -- Calculate the starting positions to center the table
    local tableStartX = math.floor((screenWidth - tableWidth) / 2) + 1
    local tableStartY = math.floor((screenHeight - tableHeight) / 2) + 1

    -- Loop through rows and columns to print the table
    for row = 0, tableHeight - 1 do
        for col = 0, tableWidth - 1 do
            local cellContent = "Cell " .. (row * tableWidth + col + 1)
            local cellX = tableStartX + col * 10  -- Adjust for cell width
            local cellY = tableStartY + row * 4   -- Adjust for cell height

            -- Set cursor position and print cell content
            term.setCursorPos(cellX, cellY)
            io.write(cellContent)
        end
    end
end

-- Example usage:
local screenWidth = 10  -- Example screen width
local screenHeight = 20  -- Example screen height

generateCenteredTable(screenWidth, screenHeight)