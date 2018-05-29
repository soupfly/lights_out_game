function love.load()
    love.window.setMode(320, 370, {resizable=true, vsync=false, minwidth=320, minheight=320})
    map = {}
    pr = {0, 0, 0, 0, 0}
    show = false
    light_on = love.graphics.newImage("gfx/light_on.png")
    light_off = love.graphics.newImage("gfx/light_off.png")
    for i = 1,50 do
        map[i] = false
        i = i + 1
    end
    toggle = function(m)
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

function love.draw()
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
    
    if show == false then
        love.graphics.print("Press z for new puzzle, Press s for hint", 10, 325)
    elseif show == true then
        love.graphics.print("Here is how it was made "..pr[5].." "..pr[4].." "..pr[3].." "..pr[2].." "..pr[1].."\nthe lights are numbered left to right, \ntop to bottom", 10, 325)
    end
end

function love.keyreleased(key)
    if key == 'z' then
        pr = {}
        for i = 0,49 do
            map[i] = false
            i = i + 1
        end
        for i = 1, 5 do
            b = math.random(1, 24)
            toggle(b)
            pr[i] = (b+1)
            i = i + 1
        end
        show = false
    elseif key == "s" then
        show = true      
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        xmap = math.floor(x/64)
        ymap = math.floor(y/64)
        m = xmap + (ymap * 5)
        toggle(m)
    end
end
