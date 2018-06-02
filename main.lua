--[[
Make a score that counts how many moves were made.

Make message that congratulates to player for winning
]]

function love.load()
--map container
    math.randomseed(os.time())
    map = {}
    undos = {0}
    count = 1
    pr_count = 0
--solution container
    pr = {0, 0, 0, 0, 0}
--sets show solution to false
    show = false
    width = 320
    height = 448
--sets the window
    love.window.setMode(width, height, {resizable=true, vsync=false, minwidth=width, minheight=width})
    light_on = love.graphics.newImage("gfx/light_on.png")
    light_off = love.graphics.newImage("gfx/light_off.png")
    bottom = love.graphics.newImage("gfx/bottom.png")
--sets all the toggles to false
    clear = function()
        for i = 0,49 do
            map[i] = false
            i = i + 1
        end
        count = 1
    end
    clear()
--creates the function toggle. this is the main game logic
    rand = function(m)
    m = math.random(4,7)
    end
    toggle = function(m)
        if m < 25 then
            if m ~= 5 then
                if m ~= 10 then
                    if m ~= 15 then
                        if m ~= 20 then
                            map[m-1] = not map[m-1]
                        end
                    end
                end
            end
            map[m] = not map[m]
            if m ~= 4 then
                if m ~= 9 then
                    if m ~= 14 then
                        if m ~= 19 then
                            map[m+1] = not map[m+1]
                        end
                    end
                end
            end
            map[m+5] = not map[m+5]
            map[m-5] = not map[m-5]
        end
    end
--this useful function measures the length of tables so the loops know how many times to count
    function tablelength(T)
        local counter = 0
        for _ in pairs(T) do counter = counter + 1 end
        return counter
    end
    c = tablelength(undos)
end

function love.draw()
--draws the boxes
    for a = 0, 4 do
        for i = 0, 4 do
            if map[i+(5*a)] == true then
            love.graphics.draw(light_on, i*64, a*64)
            else
            love.graphics.draw(light_off, i*64, a*64)
            end
            i = i + 1
        end
    end
    love.graphics.draw(bottom, 0, 320)
end

function love.keyreleased(key)

end

--mouse presses to toggle the lights and buttons
function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        xmap = math.floor(x/64)
        ymap = math.floor(y/64)
        m = xmap + (ymap * 5)
--the area below
        if m < 25 then
            count = count + 1
            undos[count] = m
--new game button
        elseif m == 25 or m == 26 or m == 27 or m == 28 then
            counter = {}
            pr = {}
            clear()
            for i = 1, 10 do
                b = math.random(2, 24)
                toggle(b)
                pr[i] = (b+1)
                i = i + 1
            end
            pr_count = 10
--undo button
        elseif m == 30 or m == 31 then
            if count > 1 then
                toggle(undos[count])
                count = count - 1
            end
--hint button
        elseif m == 33 or m == 34 then
            if count > 1 then
                toggle(undos[count])
                count = count - 1
            elseif pr_count > 0 then
                    toggle(pr[pr_count]-1)
                    pr_count = pr_count - 1
            end
        end
        toggle(m)
    end
end
